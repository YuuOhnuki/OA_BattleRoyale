scoreboard players add @s oa.water 1
scoreboard players set @s oa.wdelay 6
tag @s remove oa.water_jump
particle minecraft:splash ~ ~ ~ 0.35 0.05 0.35 0.1 12 normal @a[distance=..24]
playsound minecraft:entity.player.splash player @a[distance=..16] ~ ~ ~ 0.7 1.4
