execute if entity @s[tag=br.pvp_grace] run return 0
execute store result score #launch_roll oa.tmp run random value 1..10
execute unless score #launch_roll oa.tmp matches 1 run return 0
execute if entity @s[tag=oa.practice_dummy] run data merge entity @s {NoAI:0b,NoGravity:0b}
effect give @s minecraft:levitation 1 11 true
scoreboard players set @s oa.glift 3
particle minecraft:firework ~ ~0.2 ~ 0.4 0.1 0.4 0.1 24 normal @a[distance=..24]
playsound minecraft:entity.firework_rocket.launch player @a[distance=..24] ~ ~ ~ 1.2 1.4

tag @s add oa.gacha_lift

tag @s add oa.gacha_affected

attribute @s minecraft:fall_damage_multiplier modifier remove oa:taya_fall
attribute @s minecraft:fall_damage_multiplier modifier add oa:taya_fall -1 add_multiplied_total
tag @s add oa.taya_fall
tag @s remove oa.taya_air
scoreboard players set @s oa.tfall 0
