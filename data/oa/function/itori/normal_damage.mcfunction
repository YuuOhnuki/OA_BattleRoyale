data merge storage oa:damage {amount:2.0,type:"oa:itori_magic"}
scoreboard players set #i_base oa.tmp 20
execute if entity @s[tag=br.alive,tag=!oa.practice] if score #state br.state matches 1 if score #time br.time matches 7200.. run scoreboard players set #i_base oa.tmp 30
execute store result storage oa:damage amount float 0.1 run scoreboard players get #i_base oa.tmp
execute unless data entity @s active_effects[{id:"minecraft:strength"}] run return 0
execute store result score #i_amp oa.tmp run data get entity @s active_effects[{id:"minecraft:strength"}].amplifier
scoreboard players add #i_amp oa.tmp 1
scoreboard players set #i_three oa.tmp 3
scoreboard players operation #i_amp oa.tmp *= #i_three oa.tmp
execute store result storage oa:damage amount float 1 run scoreboard players get #i_amp oa.tmp
# Add the current base damage in fixed-point units.
scoreboard players set #i_ten oa.tmp 10
scoreboard players operation #i_amp oa.tmp *= #i_ten oa.tmp
scoreboard players operation #i_amp oa.tmp += #i_base oa.tmp
execute store result storage oa:damage amount float 0.1 run scoreboard players get #i_amp oa.tmp
