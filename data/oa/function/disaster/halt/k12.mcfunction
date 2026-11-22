# 生成：scripts/gen_disasters.py（直接編集しない）
execute if score #ds12 br.tmp matches 1.. run function oa:disaster/k12/end
scoreboard players set #ds12 br.tmp 0
