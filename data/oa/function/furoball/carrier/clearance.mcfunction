execute if entity @s[nbt={Health:0.0f}] run return run scoreboard players set #f_roof_clear oa.tmp 0
execute if entity @s[gamemode=spectator] run return run scoreboard players set #f_roof_clear oa.tmp 0
execute store result score #f_car_scale oa.tmp run attribute @s minecraft:scale get 1000
scoreboard players set #f_car_ten oa.tmp 10
scoreboard players set #f_car_18 oa.tmp 18
scoreboard players set #f_car_3 oa.tmp 3
scoreboard players operation #f_car_h oa.tmp = #f_car_scale oa.tmp
scoreboard players operation #f_car_h oa.tmp *= #f_car_18 oa.tmp
scoreboard players operation #f_car_h oa.tmp /= #f_car_ten oa.tmp
scoreboard players add #f_car_h oa.tmp 700
scoreboard players operation #f_car_w oa.tmp = #f_car_scale oa.tmp
scoreboard players operation #f_car_w oa.tmp *= #f_car_3 oa.tmp
scoreboard players operation #f_car_w oa.tmp /= #f_car_ten oa.tmp
scoreboard players set #f_car_neg oa.tmp 0
scoreboard players operation #f_car_neg oa.tmp -= #f_car_w oa.tmp
execute store result storage oa:furo_head height double 0.001 run scoreboard players get #f_car_h oa.tmp
execute store result storage oa:furo_head width double 0.001 run scoreboard players get #f_car_w oa.tmp
execute store result storage oa:furo_head neg double 0.001 run scoreboard players get #f_car_neg oa.tmp
function oa:furoball/carrier/head_probe with storage oa:furo_head
