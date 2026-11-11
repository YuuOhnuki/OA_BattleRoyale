data merge storage oa:damage {amount:1.5,type:"oa:itori_magic"}
execute unless data entity @s active_effects[{id:"minecraft:strength"}] run return 0
execute store result score #i_amp oa.tmp run data get entity @s active_effects[{id:"minecraft:strength"}].amplifier
scoreboard players add #i_amp oa.tmp 1
scoreboard players set #i_three oa.tmp 3
scoreboard players operation #i_amp oa.tmp *= #i_three oa.tmp
execute store result storage oa:damage amount float 1 run scoreboard players get #i_amp oa.tmp
# Add 1.5HP base in fixed-point units.
scoreboard players set #i_ten oa.tmp 10
scoreboard players operation #i_amp oa.tmp *= #i_ten oa.tmp
scoreboard players add #i_amp oa.tmp 15
execute store result storage oa:damage amount float 0.1 run scoreboard players get #i_amp oa.tmp
