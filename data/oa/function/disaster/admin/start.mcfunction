# 生成：scripts/gen_disasters.py（直接編集しない）
# 管理者用：/function oa:disaster/admin/start {k:4}（5秒後に1種類。試合中のみ）
execute unless score #state br.state matches 1 run return run tellraw @s {"text":"試合中だけ使えます","color":"red"}
function oa:disaster/available
function oa:disaster/plan_clear
$scoreboard players set #p$(k) br.tmp 1
function oa:disaster/plan_commit
