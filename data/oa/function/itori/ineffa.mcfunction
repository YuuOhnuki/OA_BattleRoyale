tellraw @s {"text": "イネファ：洗浄モード・定常周波数", "color": "light_purple"}
effect give @s minecraft:absorption 5 0 true
scoreboard players set @s oa.i_shield 100
tag @s add oa.itori_shield
tag @s add oa.itori_effect
execute store result storage oa:itori id int 1 run scoreboard players get @s oa.id
function oa:itori/fx/shield_mesh with storage oa:itori
playsound minecraft:block.amethyst_block.resonate player @a[distance=..24] ~ ~ ~ 1.0 0.8
playsound minecraft:item.totem.use player @a[distance=..24] ~ ~ ~ 0.25 1.7
function oa:itori/fx/shield

playsound minecraft:block.beacon.activate player @a[distance=..32] ~ ~ ~ 0.8 1.35
particle minecraft:enchant ~ ~1 ~ 1 1 1 0.25 25 normal @a[distance=..32]
