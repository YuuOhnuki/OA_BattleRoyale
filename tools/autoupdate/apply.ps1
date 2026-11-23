# OA Battle Royale: 更新を反映する（/oaplugin update apply・管理メニューが起動する。手で実行してもよい）
#   Windows: powershell -ExecutionPolicy Bypass -File autoupdate\apply.ps1      Linux: pwsh -NoProfile -File autoupdate/apply.ps1
# 2026-11-23：1回でデータパックもプラグインも反映する。
#   1) GitHub の最新のデータパックを確かめ、新しければ置く（update.ps1 -InstallOnly。ここでは再起動しない）
#   2) プラグインの jar が置いてあれば plugin-update.ps1 -Apply（予告して再起動。jar の入れ替え・確認・失敗なら戻す）。
#      その再起動で、1) で置いたデータパックも読み込まれる
#   3) jar がなければ update.ps1 -Apply（データパックだけ、予告して再起動）
# 予告は10秒（-WarnSec で変えられる）。
param([int]$WarnSec = 10)
$ErrorActionPreference = 'Stop'
$Root = Split-Path -Parent $MyInvocation.MyCommand.Path
. (Join-Path $Root 'platform.ps1')
& $OaPowerShell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $Root 'update.ps1') -InstallOnly -NoReload
$pp = Join-Path $Root 'pending-plugin.json'
if (Test-Path $pp) {
    $p = Get-Content -Raw -Encoding UTF8 $pp | ConvertFrom-Json
    $jar = Join-Path $Root ('pending/' + $p.jar)
    & $OaPowerShell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $Root 'plugin-update.ps1') -Jar $jar -Sha $p.sha -Apply -WarnSec $WarnSec
    $code = $LASTEXITCODE
    if ($code -eq 0 -or $code -eq 2) {
        Remove-Item $pp -Force -ErrorAction SilentlyContinue
        Remove-Item (Join-Path $Root 'pending') -Recurse -Force -ErrorAction SilentlyContinue
    }
    # 再起動のあとで、置いてあったデータパックが読み込まれたことを記録する（起動時刻で判定）
    & $OaPowerShell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $Root 'update.ps1')
    exit $code
}
& $OaPowerShell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $Root 'update.ps1') -Apply -WarnSec $WarnSec
exit $LASTEXITCODE
