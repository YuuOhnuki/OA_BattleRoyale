tag @s remove oa.water_jump
scoreboard players add @s oa.water 0
scoreboard players add @s oa.wdelay 0
scoreboard players remove @s[scores={oa.wdelay=1..}] oa.wdelay 1
execute if entity @s[nbt={OnGround:1b}] unless block ~ ~ ~ minecraft:water unless block ~ ~-0.3 ~ minecraft:water run scoreboard players set @s oa.water 0
execute store result score #vertical oa.tmp run data get entity @s Motion[1] 1000
execute if score @s oa.water matches ..4 if score @s oa.wdelay matches 0 if score #vertical oa.tmp matches ..0 unless block ~ ~1 ~ minecraft:water if block ~ ~ ~ minecraft:water run tag @s add oa.water_jump
execute if score @s oa.water matches ..4 if score @s oa.wdelay matches 0 if score #vertical oa.tmp matches ..0 unless block ~ ~1 ~ minecraft:water if block ~ ~-0.3 ~ minecraft:water run tag @s add oa.water_jump
