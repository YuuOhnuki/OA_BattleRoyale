# 初回導入: 今の main を導入する。以後の更新は GitHub Actions の self-hosted runner が push の直後に行う。
$ErrorActionPreference = 'Stop'
$Root = Split-Path -Parent $MyInvocation.MyCommand.Path
# 以前の版で登録した定期チェックがあれば削除する
Unregister-ScheduledTask -TaskName 'OA_BR_AutoUpdate' -Confirm:$false -ErrorAction SilentlyContinue
& (Join-Path $Root 'update.ps1') -Force
Write-Host '導入しました。ログ: autoupdate\update.log'
