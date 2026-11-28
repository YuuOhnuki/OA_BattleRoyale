# 生成：scripts/gen_disasters.py（直接編集しない）
# 橋の崩落を始める（40秒・危険度3）
function oa:disaster/k16/start
scoreboard players set #ds16 br.tmp 40
scoreboard players set #dmax16 br.tmp 40
scoreboard players set #last16 br.tmp 1
