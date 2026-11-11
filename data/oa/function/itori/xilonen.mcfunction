tellraw @s {"text": "シロネン：ヨワル・スクラッチ", "color": "gold"}
effect give @s minecraft:speed 5 1 true
attribute @s minecraft:attack_damage modifier remove oa:xilonen_damage
attribute @s minecraft:attack_damage modifier add oa:xilonen_damage 0.5 add_multiplied_total
scoreboard players set @s oa.i_boost 100
scoreboard players set @s oa.i_leap 10
execute store result score @s oa.i_yaw run data get entity @s Rotation[0] 1000
tag @s add oa.itori_boost
playsound minecraft:entity.breeze.jump player @a[distance=..24] ~ ~ ~ 0.8 1.1

tag @s add oa.itori_effect
function oa:itori/fx/emit/orange
playsound minecraft:block.amethyst_block.chime player @a[distance=..24] ~ ~ ~ 0.8 1.8

playsound minecraft:entity.firework_rocket.launch player @a[distance=..32] ~ ~ ~ 0.75 0.85
