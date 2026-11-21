# OA Battle Royale: 置いてある更新を反映する（applyMode "manual" のとき。Windows PowerShell 5.1）
# プラグインの /oaplugin update apply（管理メニュー）が起動する。手で実行してもよい：
#   powershell -ExecutionPolicy Bypass -File autoupdate\apply.ps1
# プラグインの jar が置いてあれば plugin-update.ps1 -Apply（30秒予告して再起動、jar の入れ替え・確認・失敗なら戻す）。
# 再起動で置いてあるデータパックも読み込まれる。jar がなければ update.ps1 -Apply（データパックだけ、30秒予告して再起動）。
$ErrorActionPreference = 'Stop'
$Root = Split-Path -Parent $MyInvocation.MyCommand.Path
. (Join-Path $Root 'platform.ps1')
$pp = Join-Path $Root 'pending-plugin.json'
if (Test-Path $pp) {
    $p = Get-Content -Raw -Encoding UTF8 $pp | ConvertFrom-Json
    $jar = Join-Path $Root ('pending/' + $p.jar)
    & $OaPowerShell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $Root 'plugin-update.ps1') -Jar $jar -Sha $p.sha -Apply
    $code = $LASTEXITCODE
    if ($code -eq 0 -or $code -eq 2) {
        Remove-Item $pp -Force -ErrorAction SilentlyContinue
        Remove-Item (Join-Path $Root 'pending') -Recurse -Force -ErrorAction SilentlyContinue
    }
    # 再起動のあとで、置いてあったデータパックが読み込まれたことを記録する（起動時刻で判定）
    & $OaPowerShell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $Root 'update.ps1')
    exit $code
}
& $OaPowerShell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $Root 'update.ps1') -Apply
exit $LASTEXITCODE
