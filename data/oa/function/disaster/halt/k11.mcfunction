# 生成：scripts/gen_disasters.py（直接編集しない）
execute if score #ds11 br.tmp matches 1.. run function oa:disaster/k11/end
scoreboard players set #ds11 br.tmp 0
