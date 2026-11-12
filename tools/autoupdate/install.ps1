# 初回導入: 今の main を導入し、10分ごとの自動チェック（タスクスケジューラー）を登録する
$ErrorActionPreference = 'Stop'
$Root = Split-Path -Parent $MyInvocation.MyCommand.Path
$cfg = Get-Content -Raw -Encoding UTF8 (Join-Path $Root 'config.json') | ConvertFrom-Json
& (Join-Path $Root 'update.ps1') -Force
$arg = '-NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -File "' + (Join-Path $Root 'update.ps1') + '"'
$action = New-ScheduledTaskAction -Execute 'powershell.exe' -Argument $arg
$trigger = New-ScheduledTaskTrigger -Once -At (Get-Date).AddMinutes(1) -RepetitionInterval (New-TimeSpan -Minutes $cfg.pollMinutes) -RepetitionDuration (New-TimeSpan -Days 3650)
$settings = New-ScheduledTaskSettingsSet -StartWhenAvailable -MultipleInstances IgnoreNew -ExecutionTimeLimit (New-TimeSpan -Minutes 10)
Register-ScheduledTask -TaskName 'OA_BR_AutoUpdate' -Action $action -Trigger $trigger -Settings $settings -Force | Out-Null
Write-Host '登録しました。ログ: autoupdate\update.log'
