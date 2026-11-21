# 生成：scripts/gen_disasters.py（直接編集しない）
# 竜巻を始める（15秒・危険度4）
function oa:disaster/k10/start
scoreboard players set #ds10 br.tmp 15
scoreboard players set #dmax10 br.tmp 15
scoreboard players set #last10 br.tmp 1
