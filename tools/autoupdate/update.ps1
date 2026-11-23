# OA Battle Royale: GitHub main -> server datapack auto updater (Windows PowerShell 5.1)
param([switch]$Force, [switch]$NoReload, [switch]$Apply, [switch]$InstallOnly, [int]$WarnSec = 30)
# -InstallOnly（2026-11-23）：新しい版があればデータパックを置くだけ（applyMode によらず再起動しない）。apply.ps1 が反映の前に呼ぶ
# -WarnSec：再起動の予告の秒数（apply.ps1 からは10秒）
# 反映のしかた（2026-11-15〜）：config.json の applyMode が "restart"（既定）なら、ファイルを置いたあと
#   30秒予告してサーバーを再起動する（start-server.bat のループ起動のときだけ。試合中・生成中・練習場に人がいる間は待つ）。
#   "reload" なら従来どおり /reload。大きなデータパックの /reload は60秒以上サーバーを止め、Paper の watchdog に止められたことがある。
# -NoReload：/reload は使わない（restart のときはそのまま再起動する。reload のときはファイルを置くだけ）。
# applyMode "manual"（2026-11-16〜）：push ではファイルを置くだけ。ゲーム内の /oaplugin update apply（プラグインが apply.ps1 を起動）
#   → update.ps1 -Apply で、置いてある版を30秒予告の再起動で反映する。
$ErrorActionPreference = 'Stop'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$Root = Split-Path -Parent $MyInvocation.MyCommand.Path
$ServerDir = Split-Path -Parent $Root
. (Join-Path $Root 'platform.ps1')
$cfg = Get-Content -Raw -Encoding UTF8 (Join-Path $Root 'config.json') | ConvertFrom-Json
$LogFile = Join-Path $Root 'update.log'
$StateFile = Join-Path $Root 'state.json'
$PackId = 'file/' + $cfg.packName
$DatapacksDir = Join-Path $ServerDir ($cfg.world + '/datapacks')
$PackDir = Join-Path $DatapacksDir $cfg.packName
$RestartMode = ($cfg.applyMode -ne 'reload')
$ManualMode = ($cfg.applyMode -eq 'manual') -or $InstallOnly

function Log([string]$m) {
    if ((Test-Path $LogFile) -and ((Get-Item $LogFile).Length -gt 1MB)) { Move-Item $LogFile ($LogFile + '.old') -Force }
    $l = '{0:yyyy-MM-dd HH:mm:ss} {1}' -f (Get-Date), $m
    Add-Content -Path $LogFile -Value $l -Encoding UTF8
    Write-Host $l
}
function Load-State {
    if (Test-Path $StateFile) { $s = Get-Content -Raw -Encoding UTF8 $StateFile | ConvertFrom-Json }
    else { $s = [pscustomobject]@{ installedSha = ''; etag = ''; pendingSha = ''; badSha = '' } }
    # loadedSha：サーバーが実際に読み込んでいる版（restart のとき、置いただけで再起動待ちかを見分ける）
    if (-not ($s.PSObject.Properties.Name -contains 'loadedSha')) { $s | Add-Member -NotePropertyName loadedSha -NotePropertyValue $s.installedSha }
    return $s
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
function Invoke-Rcon([string]$command, [int]$timeoutMs = 8000) {
    $c = New-Object Net.Sockets.TcpClient
    try {
        $c.ReceiveTimeout = $timeoutMs; $c.SendTimeout = 5000
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
        $p = Join-Path $base ('data/oa/' + $d)
        if (Test-Path $p) {
            foreach ($f in (Get-ChildItem $p -Recurse -File | Sort-Object FullName)) {
                $parts.Add($f.FullName.Substring($base.Length) + ':' + (Get-FileHash $f.FullName -Algorithm SHA256).Hash)
            }
        }
    }
    return ($parts -join '|')
}
function Get-LogErrors([long]$pos) {
    $latest = Join-Path $ServerDir 'logs/latest.log'
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
    $latest = Join-Path $ServerDir 'logs/latest.log'
    if (Test-Path $latest) { return (Get-Item $latest).Length }
    return 0
}
function Say([string]$msg) { if ($cfg.announce) { try { [void](Invoke-Rcon ('say ' + $msg)) } catch { } } }
# サーバーが start-server.bat（ループ起動）で動いているか。そうなら stop しても自動で起動し直す。
function Test-LoopManaged {
    if (-not $OaWindows) { return Test-OaLinuxLoop }
    $port = if ($props['server-port']) { [int]$props['server-port'] } else { 25565 }
    $c = Get-NetTCPConnection -LocalPort $port -State Listen -ErrorAction SilentlyContinue | Select-Object -First 1
    if (-not $c) { return $false }
    $p = Get-CimInstance Win32_Process -Filter ("ProcessId=" + $c.OwningProcess) -ErrorAction SilentlyContinue
    if (-not $p) { return $false }
    $parent = Get-CimInstance Win32_Process -Filter ("ProcessId=" + $p.ParentProcessId) -ErrorAction SilentlyContinue
    return [bool]($parent -and $parent.CommandLine -match 'start-server\.bat')
}
# ディメンション等が変わった更新：ループ起動中で、練習場に人がいなければ予告して再起動する
function Restart-IfPossible {
    if (-not (Test-LoopManaged)) {
        Say '[OA] ディメンション等が変わったため、完全に反映するにはサーバーの再起動が必要です'
        Log 'Dimension/type files changed: restart required (server is not run by start-server.bat, so not restarting automatically).'
        return
    }
    if ((Invoke-Rcon 'execute if entity @a[tag=oa.practice]') -match 'Test passed') {
        Say '[OA] ディメンション等が変わったため、練習場が空いたら再起動してください'
        Log 'Dimension/type files changed: restart required (practice in use, not restarting).'
        return
    }
    Say '[OA] ディメンション等の更新を反映するため、30秒後にサーバーを再起動します（1分ほどで戻ります）'
    Start-Sleep -Seconds 20
    Say '[OA] 再起動まで 10 秒'
    Start-Sleep -Seconds 10
    if ((Test-Busy)) { Say '[OA] 試合などが始まったので、再起動を延期します'; Log 'Restart postponed: a match or map job started.'; return }
    [void](Invoke-Rcon 'save-all flush' 120000)
    try { [void](Invoke-Rcon 'stop' 30000) } catch { }
    Log 'Restarting the server for dimension/type changes (start-server.bat will start it again).'
}
# サーバー（java）が起動した時刻。動いていなければ $null
function Get-ServerStartTime {
    if (-not $OaWindows) {
        $process = Get-OaLinuxServerProcess
        if ($process) { return $process.StartTime }
        return $null
    }
    $port = if ($props['server-port']) { [int]$props['server-port'] } else { 25565 }
    $c = Get-NetTCPConnection -LocalPort $port -State Listen -ErrorAction SilentlyContinue | Select-Object -First 1
    if (-not $c) { return $null }
    try { return (Get-Process -Id $c.OwningProcess -ErrorAction Stop).StartTime } catch { return $null }
}
function Test-PracticeUsed { return ((Invoke-Rcon 'execute if entity @a[tag=oa.practice]') -match 'Test passed') }
function Test-RconQuiet { if (-not $RconEnabled) { return $false }; try { [void](Invoke-Rcon 'list'); return $true } catch { return $false } }
# 止めたあと、起動し直して RCON に応えるまで待つ
function Wait-ServerBack([int]$sec) {
    Start-Sleep -Seconds 15
    $t = 15
    while ($t -lt $sec) {
        if (Test-RconQuiet) { return $true }
        Start-Sleep -Seconds 5; $t += 5
    }
    return $false
}
# 予告して再起動し、読み込みエラーがあれば前の版に戻す（restart のとき）
function Apply-ByRestart([string]$sha, [string]$short) {
    if (-not (Test-LoopManaged)) {
        $state.pendingSha = ''; Save-State $state
        Say "[OA] データパック ($short) を置きました。サーバーを再起動すると反映されます"
        Log "Installed $short, but the server is not run by start-server.bat: restart it manually to apply."
        return
    }
    Say "[OA] 更新を反映します ($short)。${WarnSec}秒後にサーバーを再起動します（1分ほどで戻ります）"
    $left = $WarnSec
    while ($left -gt 0) {
        $step = if ($left -gt 10) { $left - 10 } elseif ($left -gt 5) { $left - 5 } else { 1 }
        Start-Sleep -Seconds $step; $left -= $step
        if ($left -gt 0 -and ($left -le 5 -or $left -eq 10)) { Say "[OA] 再起動まで $left 秒" }
    }
    if ((Test-Busy) -or (Test-PracticeUsed)) {
        Say '[OA] 試合・練習などが始まったので、再起動を延期します（終わると自動で再起動します）'
        $state.pendingSha = $sha; Save-State $state
        Log "Restart for $short postponed: a match, map job or practice started."
        return
    }
    [void](Invoke-Rcon 'save-all flush' 120000)
    try { [void](Invoke-Rcon 'stop' 30000) } catch { }
    $state.pendingSha = ''; Save-State $state
    Log "Restarting the server to apply $short (start-server.bat will start it again)."
    $up = Wait-ServerBack 420
    $errs = @(Get-LogErrors 0)
    $bk = $null
    if (Test-Path (Join-Path $Root 'backup')) { $bk = Get-ChildItem (Join-Path $Root 'backup') -Directory | Sort-Object LastWriteTime -Descending | Select-Object -First 1 }
    if (((-not $up) -or ($errs.Count -gt 0)) -and $cfg.rollbackOnError -and $bk) {
        if ($up) { Log ("Load errors after restart ({0}); rolling back. First: {1}" -f $errs.Count, $errs[0].Trim()) }
        else { Log 'The server did not come back within 7 minutes; rolling back the datapack.' }
        Copy-OaMirror $bk.FullName $PackDir
        $state.badSha = $sha; $state.installedSha = ''; $state.loadedSha = ''; Save-State $state
        if ($up) {
            Say "[OA] 更新 ($short) に読み込みエラーがあったため、元の版に戻して再起動します"
            [void](Invoke-Rcon 'save-all flush' 120000)
            try { [void](Invoke-Rcon 'stop' 30000) } catch { }
        }
        Log 'Rolled back to the previous version.'
        return
    }
    if ($errs.Count -gt 0) { Log ("Load errors after restart ({0}), no rollback. First: {1}" -f $errs.Count, $errs[0].Trim()) }
    $state.loadedSha = $sha; Save-State $state
    Log "Restarted ($short)."
}

# ---------- main ----------
$lock = $null
$resultCode = 0
try { $lock = [IO.File]::Open((Join-Path $Root 'update.lock'), 'OpenOrCreate', 'ReadWrite', 'None') } catch { exit 0 }
try {
    $state = Load-State
    # 置いたあとにサーバーが起動し直していれば（プラグインの更新の再起動など）、置いてある版はもう読み込まれている
    if ($state.installedSha -and ($state.loadedSha -ne $state.installedSha) -and $state.installedAt) {
        $st0 = Get-ServerStartTime
        if ($st0 -and ($st0 -gt [datetime]::Parse($state.installedAt))) {
            $state.loadedSha = $state.installedSha; $state.pendingSha = ''; Save-State $state
            Log "Loaded $($state.installedSha.Substring(0, 7)) (the server restarted after it was installed)."
        }
    }
    if ($Apply) {
        if ($state.installedSha -and ($state.loadedSha -ne $state.installedSha) -and (Test-Rcon)) {
            if ((Test-Busy) -or (Test-PracticeUsed)) { Say '[OA] 試合・練習・生成の最中なので、更新は反映しませんでした'; Log 'Manual apply refused: a match, map job or practice is running.'; exit 0 }
            Apply-ByRestart $state.installedSha $state.installedSha.Substring(0, 7)
        } else { Log 'Manual apply: nothing to apply (the installed datapack is already loaded).' }
        exit 0
    }
    $remote = Get-RemoteSha ($(if ($Force) { '' } else { $state.etag }))
    $target = $remote.sha
    if (-not $target) { $target = $state.pendingSha }          # 304: use pending if any
    if (-not $target -and $Force) { $target = (Get-RemoteSha '').sha }
    if (-not $target) { exit 0 }
    $packExists = Test-Path (Join-Path $PackDir 'pack.mcmeta')
    if (($target -eq $state.installedSha) -and $packExists -and -not $Force) {
        # restart のとき：置いてあるが、まだ再起動していない版（延期された）なら、空いていれば再起動する
        # 置いたあとにサーバーが起動し直していれば（プラグインの更新の再起動など）、もう読み込まれている
        if ($RestartMode -and ($state.loadedSha -ne $target) -and $state.installedAt) {
            $st = Get-ServerStartTime
            if ($st -and ($st -gt [datetime]::Parse($state.installedAt))) { $state.loadedSha = $target; $state.pendingSha = ''; Save-State $state; Log "Loaded $($target.Substring(0, 7)) (the server restarted after it was installed)."; exit 0 }
        }
        if ($ManualMode) { $state.etag = $remote.etag; $state.pendingSha = ''; Save-State $state; exit 0 }
        if ($RestartMode -and ($state.loadedSha -ne $target) -and (Test-Rcon)) {
            if ((Test-Busy) -or (Test-PracticeUsed)) { $state.pendingSha = $target; Save-State $state; exit 0 }
            Apply-ByRestart $target $target.Substring(0, 7)
            exit 0
        }
        $state.etag = $remote.etag; $state.pendingSha = ''; Save-State $state; exit 0
    }
    if (($target -eq $state.badSha) -and -not $Force) { exit 0 }
    $short = $target.Substring(0, 7)
    $rconOk = (Test-Rcon) -and ($RestartMode -or (-not $NoReload))
    if ((-not $ManualMode) -and $rconOk -and $packExists -and ((Test-Busy) -or ($RestartMode -and (Test-PracticeUsed)))) {
        if ($state.pendingSha -ne $target) { Log "Update $short pending: a match, map job or practice is running."; }
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
    if (-not (Test-Path (Join-Path $src 'pack.mcmeta')) -or -not (Test-Path (Join-Path $src 'data/oa/function'))) { throw 'downloaded repo has no pack.mcmeta/data' }
    $null = Read-OaJson (Join-Path $src 'pack.mcmeta')
    $bad = 0
    foreach ($f in (Get-ChildItem (Join-Path $src 'data') -Recurse -Include *.json -File)) {
        try { $null = Read-OaJson $f.FullName }
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
        $bk = Join-Path $Root ('backup/' + $(if ($state.installedSha) { $state.installedSha.Substring(0, 7) } else { 'prev' }))
        if (Test-Path $bk) { Remove-Item $bk -Recurse -Force }
        New-Item -ItemType Directory -Path $bk -Force | Out-Null
        Copy-OaMirror $PackDir $bk
        Get-ChildItem (Join-Path $Root 'backup') -Directory | Sort-Object LastWriteTime -Descending | Select-Object -Skip $cfg.keepBackups | Remove-Item -Recurse -Force
    } else { $needsRestart = $true }
    if (-not (Test-Path $DatapacksDir)) { throw "datapacks dir not found: $DatapacksDir" }
    New-Item -ItemType Directory -Path $PackDir -Force | Out-Null
    $logPos = Get-LogPos
    Copy-OaMirror $stage $PackDir
    $state.installedSha = $target; $state.pendingSha = ''; $state.etag = $remote.etag
    if (-not ($state.PSObject.Properties.Name -contains 'installedAt')) { $state | Add-Member -NotePropertyName installedAt -NotePropertyValue '' }
    $state.installedAt = (Get-Date).ToString('o'); Save-State $state
    Log "Installed $short into $PackDir"

    # retire old manually placed OA packs (zip/folders) so only the managed one is loaded
    if ($cfg.retireOldPacks) {
        $ret = Join-Path $Root 'retired'
        Get-ChildItem $DatapacksDir | Where-Object { $_.Name -like 'OA_BattleRoyale*' -and $_.Name -ne $cfg.packName } | ForEach-Object {
            try { New-Item -ItemType Directory -Path $ret -Force | Out-Null; Move-Item $_.FullName (Join-Path $ret $_.Name) -Force; Log ('Moved old pack to retired: ' + $_.Name) }
            catch { Log ('Could not move old pack (in use?): ' + $_.Name) }
        }
    }

    if ($ManualMode) {
        Say "[OA] データパックの更新 ($short) を置きました。管理者が /oaplugin update apply（管理メニュー）で反映します"
        Log "Installed $short; waiting for manual apply (/oaplugin update apply)."
    } elseif ($rconOk -and $RestartMode) {
        Apply-ByRestart $target $short
    } elseif ($rconOk) {
        Say "[OA] データパックを更新します ($short)"
        [void](Invoke-Rcon 'reload' 90000)   # reload は数十秒かかることがある（返事が来るまでサーバーが止まる）
        Start-Sleep -Seconds $cfg.reloadWaitSec
        # make sure the managed pack is enabled; disable old OA packs
        $list = Invoke-Rcon 'datapack list enabled'
        # 一覧は「[file/OA_BattleRoyale_auto (world)]」のように後ろに出どころが付くので、名前だけで比べる
        # （以前は付いた形で比べていたため、更新のたびに自分自身を無効化→有効化していた）
        if ($list -notmatch ([regex]::Escape('[' + $PackId) + '[\] ]')) {
            foreach ($m in [regex]::Matches($list, '\[(file/OA_BattleRoyale[^\]\s]*)[^\]]*\]')) {
                if ($m.Groups[1].Value -ne $PackId) { [void](Invoke-Rcon ('datapack disable "' + $m.Groups[1].Value + '"') 90000); Log ('Disabled old pack ' + $m.Groups[1].Value) }
            }
            [void](Invoke-Rcon ('datapack enable "' + $PackId + '"') 90000)
            Log "Enabled $PackId"
            Start-Sleep -Seconds $cfg.reloadWaitSec
        }
        $errs = @(Get-LogErrors $logPos)   # 1件だけのとき文字列になり $errs[0] が1文字になるのを防ぐ
        if ($errs.Count -gt 0 -and $cfg.rollbackOnError -and $hadPack) {
            Log ("Load errors after reload ({0}); rolling back. First: {1}" -f $errs.Count, $errs[0].Trim())
            $bk = Get-ChildItem (Join-Path $Root 'backup') -Directory | Sort-Object LastWriteTime -Descending | Select-Object -First 1
            Copy-OaMirror $bk.FullName $PackDir
            [void](Invoke-Rcon 'reload' 90000)
            $state.badSha = $target; $state.installedSha = ''; Save-State $state
            Say "[OA] 更新 ($short) に読み込みエラーがあったため元に戻しました"
            Log 'Rolled back to the previous version.'
        } else {
            if ($errs.Count -gt 0) { Log ("Load errors after reload ({0}), no rollback. First: {1}" -f $errs.Count, $errs[0].Trim()) }
            $state.loadedSha = $target; Save-State $state
            Log "Reloaded ($short)."
            if ($needsRestart) { Restart-IfPossible }
        }
    } else {
        Log 'No RCON reload. Run /reload (or restart) on the server to apply.'
        if ($needsRestart) { Log 'Dimension/type files changed or first install: restart the server.' }
    }
} catch {
    Log ('ERROR: ' + $_.Exception.Message)
    $resultCode = 1
} finally {
    $global:LASTEXITCODE = 0   # robocopy の終了コード(1=コピー成功)を CI の失敗扱いにしない
    if ($lock) { $lock.Close() }
    $t = Join-Path $Root 'tmp'
    if (Test-Path $t) { Remove-Item $t -Recurse -Force -ErrorAction SilentlyContinue }
}
exit $resultCode
