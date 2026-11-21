# 生成：scripts/gen_disasters.py（直接編集しない）
# 管理者用：/function oa:disaster/admin/multi {n:2}（このマップの災害から n 種類を抽選して5秒後に。試合中のみ）
execute unless score #state br.state matches 1 run return run tellraw @s {"text":"試合中だけ使えます","color":"red"}
function oa:disaster/available
function oa:disaster/plan_clear
scoreboard players set #avoid_last br.tmp 0
$scoreboard players set #want br.tmp $(n)
function oa:disaster/pick_n
function oa:disaster/plan_commit
