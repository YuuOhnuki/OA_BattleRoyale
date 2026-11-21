# Shared by update.ps1 and plugin-update.ps1. Windows PowerShell 5.1 / PowerShell 7.
$OaWindows = [Environment]::OSVersion.Platform -eq [PlatformID]::Win32NT
$OaPowerShell = if ($OaWindows) { Join-Path $env:WINDIR 'System32/WindowsPowerShell/v1.0/powershell.exe' } else { Join-Path $PSHOME 'pwsh' }

function Get-OaLinuxServerProcess {
    $file = Join-Path $Root 'server.pid'
    if (-not (Test-Path $file)) { return $null }
    try {
        $serverPid = [int](Get-Content -Raw $file).Trim()
        $cwd = (Get-Item "/proc/$serverPid/cwd" -Force).Target
        if ([IO.Path]::GetFullPath($cwd) -ne [IO.Path]::GetFullPath($ServerDir)) { return $null }
        $cmdline = [IO.File]::ReadAllText("/proc/$serverPid/cmdline")
        if ($cmdline -notmatch '(?s)java\x00.*-jar\x00') { return $null }
        return Get-Process -Id $serverPid -ErrorAction Stop
    } catch { return $null }
}
function Test-OaLinuxLoop {
    $server = Get-OaLinuxServerProcess
    if (-not $server) { return $false }
    try {
        $loopPid = [int](Get-Content -Raw (Join-Path $Root 'loop.pid')).Trim()
        $status = [IO.File]::ReadAllText("/proc/$($server.Id)/status")
        $cmdline = [IO.File]::ReadAllText("/proc/$loopPid/cmdline")
        return ($status -match "(?m)^PPid:\s+$loopPid\s*$") -and ($cmdline -match 'start-server\.sh')
    } catch { return $false }
}
function Test-OaPort([int]$port) {
    $client = New-Object Net.Sockets.TcpClient
    try {
        $task = $client.ConnectAsync('127.0.0.1', $port)
        return $task.Wait(1000) -and $client.Connected
    } catch { return $false } finally { $client.Dispose() }
}
function Copy-OaMirror([string]$source, [string]$destination) {
    if (-not (Test-Path -LiteralPath $source -PathType Container)) { throw "Missing source: $source" }
    if ($OaWindows) {
        & robocopy $source $destination /MIR /NFL /NDL /NJH /NJS /NP | Out-Null
        if ($LASTEXITCODE -ge 8) { throw "robocopy failed ($LASTEXITCODE)" }
    } else {
        & rsync -a --delete -- ($source.TrimEnd('/') + '/') ($destination.TrimEnd('/') + '/')
        if ($LASTEXITCODE -ne 0) { throw "rsync failed ($LASTEXITCODE)" }
    }
}
function Read-OaJson([string]$path) {
    $text = [IO.File]::ReadAllText($path, [Text.Encoding]::UTF8)
    if ($PSVersionTable.PSVersion.Major -ge 6) {
        return ConvertFrom-Json -InputObject $text -Depth 1000 -ErrorAction Stop
    }
    Add-Type -AssemblyName System.Web.Extensions
    $serializer = New-Object System.Web.Script.Serialization.JavaScriptSerializer
    $serializer.MaxJsonLength = [int]::MaxValue
    $serializer.RecursionLimit = 1000
    return $serializer.DeserializeObject($text)
}
