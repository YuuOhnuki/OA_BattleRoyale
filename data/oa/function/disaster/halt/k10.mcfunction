# 生成：scripts/gen_disasters.py（直接編集しない）
execute if score #ds10 br.tmp matches 1.. run function oa:disaster/k10/end
scoreboard players set #ds10 br.tmp 0
