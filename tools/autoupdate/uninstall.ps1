# 自動チェックを止める（導入済みのデータパックはそのまま残る）
Unregister-ScheduledTask -TaskName 'OA_BR_AutoUpdate' -Confirm:$false
Write-Host '自動更新を停止しました。'
