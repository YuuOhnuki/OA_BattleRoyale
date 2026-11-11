execute if data storage oa:lobby_events {working:1b} run return run tellraw @s {text:"ロビー表示更新の完了後に実行してください。",color:"yellow"}
execute unless entity @s[tag=br.admin] run return run tellraw @s {text:"登録済み管理者のみ実行できます。",color:"red"}
execute unless score #state br.state matches 0 run return run tellraw @s {text:"試合停止中に実行してください。",color:"red"}
execute unless data storage oa:lobby origin{ready:1b} run return run tellraw @s {text:"削除するロビーが登録されていません。",color:"yellow"}
execute if data storage oa:lobby_job {working:1b} run return 0
data modify storage oa:lobby_job mode set value "delete"
function oa:lobby/job_begin
