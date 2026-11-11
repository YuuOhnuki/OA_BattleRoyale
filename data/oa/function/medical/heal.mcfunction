execute if entity @s[nbt={Health:0.0f}] run return 0
execute store result score #med_hp oa.tmp run data get entity @s Health 1000
execute store result score #med_max oa.tmp run attribute @s minecraft:max_health get 1000
$scoreboard players add #med_hp oa.tmp $(milli)
execute if score #med_hp oa.tmp > #med_max oa.tmp run scoreboard players operation #med_hp oa.tmp = #med_max oa.tmp
scoreboard players operation #med_hp oa.tmp -= #med_max oa.tmp
execute store result storage oa:medical cap double 0.001 run scoreboard players get #med_hp oa.tmp
function oa:medical/cap with storage oa:medical
