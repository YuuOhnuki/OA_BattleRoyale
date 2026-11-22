# 生成：scripts/gen_disasters.py（直接編集しない）
# 起きている災害（#dsN≥1）をそれぞれ1秒進める。#dis_active＝数、#dis_kind＝一番小さい番号（互換）
scoreboard players set @a br.ddmg 0
execute if score #ds1 br.tmp matches 1.. run function oa:disaster/run/k1
execute if score #ds2 br.tmp matches 1.. run function oa:disaster/run/k2
execute if score #ds3 br.tmp matches 1.. run function oa:disaster/run/k3
execute if score #ds4 br.tmp matches 1.. run function oa:disaster/run/k4
execute if score #ds5 br.tmp matches 1.. run function oa:disaster/run/k5
execute if score #ds6 br.tmp matches 1.. run function oa:disaster/run/k6
execute if score #ds7 br.tmp matches 1.. run function oa:disaster/run/k7
execute if score #ds8 br.tmp matches 1.. run function oa:disaster/run/k8
execute if score #ds9 br.tmp matches 1.. run function oa:disaster/run/k9
execute if score #ds10 br.tmp matches 1.. run function oa:disaster/run/k10
execute if score #ds11 br.tmp matches 1.. run function oa:disaster/run/k11
execute if score #ds12 br.tmp matches 1.. run function oa:disaster/run/k12
function oa:disaster/count
