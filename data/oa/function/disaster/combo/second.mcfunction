# 1.9.191: 災害コンボの1秒（disaster/second から）
execute if score #dc_warn br.tmp matches 1.. run return run function oa:disaster/combo/warn
scoreboard players add #dc_t br.tmp 1
scoreboard players operation #dc_save br.tmp = #dis_left br.tmp
# 通常の災害が起きていなければ、アクションバーの警告をこちらで出す（3秒ごとに交互）
execute unless score #dis_kind br.tmp matches 1.. run tag @a remove br.dis_msg
execute unless score #dis_kind br.tmp matches 1.. run scoreboard players set #dis_phase br.tmp 0
scoreboard players operation #dc_ph br.tmp = #dc_t br.tmp
scoreboard players operation #dc_ph br.tmp /= #3 br.tmp
scoreboard players set #c2 br.tmp 2
scoreboard players operation #dc_ph br.tmp %= #c2 br.tmp
execute unless score #dis_kind br.tmp matches 1.. if score #dc_ph br.tmp matches 0 unless score #sup_phase br.tmp matches 1 run scoreboard players set #dis_phase br.tmp 1
execute if score #dc1 br.tmp matches 1.. run function oa:disaster/combo/k1
execute if score #dc2 br.tmp matches 1.. run function oa:disaster/combo/k2
execute if score #dc3 br.tmp matches 1.. run function oa:disaster/combo/k3
execute if score #dc4 br.tmp matches 1.. run function oa:disaster/combo/k4
execute if score #dc5 br.tmp matches 1.. run function oa:disaster/combo/k5
execute if score #dc6 br.tmp matches 1.. run function oa:disaster/combo/k6
scoreboard players operation #dis_left br.tmp = #dc_save br.tmp
execute unless score #dc1 br.tmp matches 1.. unless score #dc2 br.tmp matches 1.. unless score #dc3 br.tmp matches 1.. unless score #dc4 br.tmp matches 1.. unless score #dc5 br.tmp matches 1.. unless score #dc6 br.tmp matches 1.. run function oa:disaster/combo/end
