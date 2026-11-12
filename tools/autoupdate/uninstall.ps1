# 旧版で登録した定期チェックを削除する（導入済みのデータパックはそのまま残る）。自動更新を止めるには runner を止める。
Unregister-ScheduledTask -TaskName 'OA_BR_AutoUpdate' -Confirm:$false -ErrorAction SilentlyContinue
Write-Host '定期チェックを削除しました。'
