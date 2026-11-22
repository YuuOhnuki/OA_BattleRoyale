# 生成：scripts/gen_disasters.py（直接編集しない）
# 塔の砲撃を始める（45秒・危険度4）
function oa:disaster/k12/start
scoreboard players set #ds12 br.tmp 45
scoreboard players set #dmax12 br.tmp 45
scoreboard players set #last12 br.tmp 1
