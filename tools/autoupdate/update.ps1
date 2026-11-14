# OA Battle Royale: GitHub main -> server datapack auto updater (Windows PowerShell 5.1)
param([switch]$Force, [switch]$NoReload)
$ErrorActionPreference = 'Stop'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$Root = Split-Path -Parent $MyInvocation.MyCommand.Path
$ServerDir = Split-Path -Parent $Root
$cfg = Get-Content -Raw -Encoding UTF8 (Join-Path $Root 'config.json') | ConvertFrom-Json
$LogFile = Join-Path $Root 'update.log'
$StateFile = Join-Path $Root 'state.json'
$PackId = 'file/' + $cfg.packName
$DatapacksDir = Join-Path $ServerDir ($cfg.world + '\datapacks')
$PackDir = Join-Path $DatapacksDir $cfg.packName

function Log([string]$m) {
    if ((Test-Path $LogFile) -and ((Get-Item $LogFile).Length -gt 1MB)) { Move-Item $LogFile ($LogFile + '.old') -Force }
    $l = '{0:yyyy-MM-dd HH:mm:ss} {1}' -f (Get-Date), $m
    Add-Content -Path $LogFile -Value $l -Encoding UTF8
    Write-Host $l
}
function Load-State {
    if (Test-Path $StateFile) { return (Get-Content -Raw -Encoding UTF8 $StateFile | ConvertFrom-Json) }
    return ([pscustomobject]@{ installedSha = ''; etag = ''; pendingSha = ''; badSha = '' })
}
function Save-State($s) { $s | ConvertTo-Json | Set-Content -Encoding UTF8 $StateFile }

# ---------- RCON ----------
$props = @{}
$propFile = Join-Path $ServerDir 'server.properties'
if (Test-Path $propFile) {
    foreach ($line in (Get-Content -Encoding UTF8 $propFile)) {
        if ($line -match '^\s*([^#=\s][^=]*)=(.*)$') { $props[$Matches[1].Trim()] = $Matches[2].Trim() }
    }
}
$RconEnabled = ($props['enable-rcon'] -eq 'true') -and $props['rcon.password']
$RconHost = '127.0.0.1'
$RconPort = if ($props['rcon.port']) { [int]$props['rcon.port'] } else { 25575 }

function Read-Exact($stream, [int]$n) {
    $buf = New-Object byte[] $n; $off = 0
    while ($off -lt $n) {
        $r = $stream.Read($buf, $off, $n - $off)
        if ($r -le 0) { throw 'rcon: connection closed' }
        $off += $r
    }
    return $buf
}
function Send-Packet($stream, [int]$id, [int]$type, [string]$body) {
    $b = [Text.Encoding]::UTF8.GetBytes($body)
    $ms = New-Object IO.MemoryStream
    $bw = New-Object IO.BinaryWriter($ms)
    $bw.Write([int32](10 + $b.Length)); $bw.Write([int32]$id); $bw.Write([int32]$type)
    $bw.Write($b); $bw.Write([byte]0); $bw.Write([byte]0); $bw.Flush()
    $arr = $ms.ToArray(); $stream.Write($arr, 0, $arr.Length)
}
function Read-Packet($stream) {
    $len = [BitConverter]::ToInt32((Read-Exact $stream 4), 0)
    $data = Read-Exact $stream $len
    $id = [BitConverter]::ToInt32($data, 0); $type = [BitConverter]::ToInt32($data, 4)
    $body = ''
    if ($len -gt 10) { $body = [Text.Encoding]::UTF8.GetString($data, 8, $len - 10) }
    return [pscustomobject]@{ id = $id; type = $type; body = $body }
}
function Invoke-Rcon([string]$command) {
    $c = New-Object Net.Sockets.TcpClient
    try {
        $c.ReceiveTimeout = 8000; $c.SendTimeout = 5000
        $iar = $c.BeginConnect($RconHost, $RconPort, $null, $null)
        if (-not $iar.AsyncWaitHandle.WaitOne(3000)) { throw 'rcon: connect timeout' }
        $c.EndConnect($iar)
        $s = $c.GetStream()
        Send-Packet $s 1 3 $props['rcon.password']
        $ok = $false
        for ($i = 0; $i -lt 3; $i++) {
            $p = Read-Packet $s
            if ($p.id -eq -1) { throw 'rcon: bad password' }
            if ($p.type -eq 2) { $ok = $true; break }
        }
        if (-not $ok) { throw 'rcon: auth failed' }
        Send-Packet $s 2 2 $command
        $p = Read-Packet $s
        return $p.body
    } finally { $c.Close() }
}
function Test-Rcon {
    if (-not $RconEnabled) { return $false }
    try { [void](Invoke-Rcon 'list'); return $true } catch { Log ('RCON unavailable: ' + $_.Exception.Message); return $false }
}
function Test-Busy {
    $checks = @('execute if score #state br.state matches 1..',
                'execute if data storage oa_map2:job {working:1b}',
                'execute if score #state oa.map2 matches 1',
                'execute if score #state oa.map2 matches 4')
    foreach ($c in $checks) { if ((Invoke-Rcon $c) -match 'Test passed') { return $true } }
    return $false
}

# ---------- GitHub ----------
function Get-RemoteSha([string]$etag) {
    $req = [Net.HttpWebRequest]::Create('https://api.github.com/repos/' + $cfg.repo + '/commits/' + $cfg.branch)
    $req.UserAgent = 'OA-BR-AutoUpdate'; $req.Accept = 'application/vnd.github.sha'; $req.Timeout = 20000
    if ($etag) { $req.Headers['If-None-Match'] = $etag }
    try { $resp = $req.GetResponse() }
    catch [Net.WebException] {
        if ($_.Exception.Response -and ([int]$_.Exception.Response.StatusCode -eq 304)) { return [pscustomobject]@{ sha = ''; etag = $etag } }
        throw
    }
    try {
        $sr = New-Object IO.StreamReader($resp.GetResponseStream())
        $sha = $sr.ReadToEnd().Trim()
        return [pscustomobject]@{ sha = $sha; etag = $resp.Headers['ETag'] }
    } finally { $resp.Close() }
}
function Hash-Tree([string]$base) {
    $parts = New-Object System.Collections.Generic.List[string]
    foreach ($d in @('dimension', 'dimension_type', 'worldgen', 'timeline', 'world_clock')) {
        $p = Join-Path $base ('data\oa\' + $d)
        if (Test-Path $p) {
            foreach ($f in (Get-ChildItem $p -Recurse -File | Sort-Object FullName)) {
                $parts.Add($f.FullName.Substring($base.Length) + ':' + (Get-FileHash $f.FullName -Algorithm SHA256).Hash)
            }
        }
    }
    return ($parts -join '|')
}
function Get-LogErrors([long]$pos) {
    $latest = Join-Path $ServerDir 'logs\latest.log'
    if (-not (Test-Path $latest)) { return @() }
    $fs = [IO.File]::Open($latest, 'Open', 'Read', 'ReadWrite')
    try {
        if ($fs.Length -lt $pos) { $pos = 0 }
        [void]$fs.Seek($pos, 'Begin')
        $text = (New-Object IO.StreamReader($fs, [Text.Encoding]::UTF8)).ReadToEnd()
    } finally { $fs.Close() }
    return @($text -split "`n" | Where-Object { $_ -match '/ERROR\]' -and $_ -match 'Failed to load|Whilst parsing|Couldn''t|Failed to parse|Failed to reload' })
}
function Get-LogPos {
    $latest = Join-Path $ServerDir 'logs\latest.log'
    if (Test-Path $latest) { return (Get-Item $latest).Length }
    return 0
}
function Say([string]$msg) { if ($cfg.announce) { try { [void](Invoke-Rcon ('say ' + $msg)) } catch { } } }

# ---------- main ----------
$lock = $null
try { $lock = [IO.File]::Open((Join-Path $Root 'update.lock'), 'OpenOrCreate', 'ReadWrite', 'None') } catch { exit 0 }
try {
    $state = Load-State
    $remote = Get-RemoteSha ($(if ($Force) { '' } else { $state.etag }))
    $target = $remote.sha
    if (-not $target) { $target = $state.pendingSha }          # 304: use pending if any
    if (-not $target -and $Force) { $target = (Get-RemoteSha '').sha }
    if (-not $target) { exit 0 }
    $packExists = Test-Path (Join-Path $PackDir 'pack.mcmeta')
    if (($target -eq $state.installedSha) -and $packExists -and -not $Force) {
        $state.etag = $remote.etag; $state.pendingSha = ''; Save-State $state; exit 0
    }
    if (($target -eq $state.badSha) -and -not $Force) { exit 0 }
    $short = $target.Substring(0, 7)
    $rconOk = (-not $NoReload) -and (Test-Rcon)
    if ($rconOk -and (Test-Busy) -and $packExists) {
        if ($state.pendingSha -ne $target) { Log "Update $short pending: a match or map job is running."; }
        $state.pendingSha = $target; $state.etag = ''; Save-State $state; exit 0
    }
    if ((-not $rconOk) -and (-not $cfg.applyWithoutRcon)) { Log 'RCON unavailable and applyWithoutRcon=false: skipped.'; exit 0 }

    # download + validate
    $tmp = Join-Path $Root 'tmp'
    if (Test-Path $tmp) { Remove-Item $tmp -Recurse -Force }
    New-Item -ItemType Directory -Path $tmp | Out-Null
    $zip = Join-Path $tmp 'src.zip'
    $wc = New-Object Net.WebClient; $wc.Headers['User-Agent'] = 'OA-BR-AutoUpdate'
    $wc.DownloadFile('https://codeload.github.com/' + $cfg.repo + '/zip/' + $target, $zip)
    Add-Type -AssemblyName System.IO.Compression.FileSystem
    [IO.Compression.ZipFile]::ExtractToDirectory($zip, (Join-Path $tmp 'x'))
    $src = (Get-ChildItem (Join-Path $tmp 'x') -Directory | Select-Object -First 1).FullName
    if (-not (Test-Path (Join-Path $src 'pack.mcmeta')) -or -not (Test-Path (Join-Path $src 'data\oa\function'))) { throw 'downloaded repo has no pack.mcmeta/data' }
    Add-Type -AssemblyName System.Web.Extensions
    $ser = New-Object System.Web.Script.Serialization.JavaScriptSerializer
    $ser.MaxJsonLength = [int]::MaxValue; $ser.RecursionLimit = 1000
    $null = $ser.DeserializeObject([IO.File]::ReadAllText((Join-Path $src 'pack.mcmeta'), [Text.Encoding]::UTF8))
    $bad = 0
    foreach ($f in (Get-ChildItem (Join-Path $src 'data') -Recurse -Include *.json -File)) {
        try { $null = $ser.DeserializeObject([IO.File]::ReadAllText($f.FullName, [Text.Encoding]::UTF8)) }
        catch { $bad++; Log ('Invalid JSON: ' + $f.FullName.Substring($src.Length)) }
    }
    if ($bad -gt 0) { $state.badSha = $target; Save-State $state; throw "$bad invalid JSON file(s); not installed ($short)" }
    $stage = Join-Path $tmp 'pack'
    New-Item -ItemType Directory -Path $stage | Out-Null
    Copy-Item (Join-Path $src 'pack.mcmeta') $stage
    if (Test-Path (Join-Path $src 'pack.png')) { Copy-Item (Join-Path $src 'pack.png') $stage }
    Copy-Item (Join-Path $src 'data') (Join-Path $stage 'data') -Recurse

    # backup + apply
    $needsRestart = $false
    $hadPack = $packExists
    if ($hadPack) {
        $needsRestart = (Hash-Tree $PackDir) -ne (Hash-Tree $stage)
        $bk = Join-Path $Root ('backup\' + $(if ($state.installedSha) { $state.installedSha.Substring(0, 7) } else { 'prev' }))
        if (Test-Path $bk) { Remove-Item $bk -Recurse -Force }
        New-Item -ItemType Directory -Path $bk -Force | Out-Null
        & robocopy $PackDir $bk /MIR /NFL /NDL /NJH /NJS /NP | Out-Null
        Get-ChildItem (Join-Path $Root 'backup') -Directory | Sort-Object LastWriteTime -Descending | Select-Object -Skip $cfg.keepBackups | Remove-Item -Recurse -Force
    } else { $needsRestart = $true }
    if (-not (Test-Path $DatapacksDir)) { throw "datapacks dir not found: $DatapacksDir" }
    New-Item -ItemType Directory -Path $PackDir -Force | Out-Null
    $logPos = Get-LogPos
    & robocopy $stage $PackDir /MIR /NFL /NDL /NJH /NJS /NP | Out-Null
    if ($LASTEXITCODE -ge 8) { throw "robocopy failed ($LASTEXITCODE)" }
    $state.installedSha = $target; $state.pendingSha = ''; $state.etag = $remote.etag; Save-State $state
    Log "Installed $short into $PackDir"

    # retire old manually placed OA packs (zip/folders) so only the managed one is loaded
    if ($cfg.retireOldPacks) {
        $ret = Join-Path $Root 'retired'
        Get-ChildItem $DatapacksDir | Where-Object { $_.Name -like 'OA_BattleRoyale*' -and $_.Name -ne $cfg.packName } | ForEach-Object {
            try { New-Item -ItemType Directory -Path $ret -Force | Out-Null; Move-Item $_.FullName (Join-Path $ret $_.Name) -Force; Log ('Moved old pack to retired: ' + $_.Name) }
            catch { Log ('Could not move old pack (in use?): ' + $_.Name) }
        }
    }

    if ($rconOk) {
        Say "[OA] データパックを更新します ($short)"
        [void](Invoke-Rcon 'reload')
        Start-Sleep -Seconds $cfg.reloadWaitSec
        # make sure the managed pack is enabled; disable old OA packs
        $list = Invoke-Rcon 'datapack list enabled'
        if ($list -notmatch [regex]::Escape('[' + $PackId + ']')) {
            foreach ($m in [regex]::Matches($list, '\[(file/OA_BattleRoyale[^\]]*)\]')) {
                if ($m.Groups[1].Value -ne $PackId) { [void](Invoke-Rcon ('datapack disable "' + $m.Groups[1].Value + '"')); Log ('Disabled old pack ' + $m.Groups[1].Value) }
            }
            [void](Invoke-Rcon ('datapack enable "' + $PackId + '"'))
            Log "Enabled $PackId"
            Start-Sleep -Seconds $cfg.reloadWaitSec
        }
        $errs = @(Get-LogErrors $logPos)   # 1件だけのとき文字列になり $errs[0] が1文字になるのを防ぐ
        if ($errs.Count -gt 0 -and $cfg.rollbackOnError -and $hadPack) {
            Log ("Load errors after reload ({0}); rolling back. First: {1}" -f $errs.Count, $errs[0].Trim())
            $bk = Get-ChildItem (Join-Path $Root 'backup') -Directory | Sort-Object LastWriteTime -Descending | Select-Object -First 1
            & robocopy $bk.FullName $PackDir /MIR /NFL /NDL /NJH /NJS /NP | Out-Null
            [void](Invoke-Rcon 'reload')
            $state.badSha = $target; $state.installedSha = ''; Save-State $state
            Say "[OA] 更新 ($short) に読み込みエラーがあったため元に戻しました"
            Log 'Rolled back to the previous version.'
        } else {
            if ($errs.Count -gt 0) { Log ("Load errors after reload ({0}), no rollback. First: {1}" -f $errs.Count, $errs[0].Trim()) }
            Log "Reloaded ($short)."
            if ($needsRestart) {
                Say '[OA] ディメンション等が変わったため、完全に反映するにはサーバーの再起動が必要です'
                Log 'Dimension/type/biome/timeline files changed: a server restart is required.'
            }
        }
    } else {
        Log 'No RCON reload. Run /reload (or restart) on the server to apply.'
        if ($needsRestart) { Log 'Dimension/type files changed or first install: restart the server.' }
    }
} catch {
    Log ('ERROR: ' + $_.Exception.Message)
} finally {
    $global:LASTEXITCODE = 0   # robocopy の終了コード(1=コピー成功)を CI の失敗扱いにしない
    if ($lock) { $lock.Close() }
    $t = Join-Path $Root 'tmp'
    if (Test-Path $t) { Remove-Item $t -Recurse -Force -ErrorAction SilentlyContinue }
}
