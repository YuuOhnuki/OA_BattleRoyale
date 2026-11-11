execute unless score @s oa.small matches 1.. run return 0
scoreboard players remove @s oa.small 1
execute if score @s oa.small matches 0 run return run function oa:komame/cleanup
execute if score #clock oa.beat matches 5.. run function oa:komame/fx
execute if score @s oa.small matches 180 run playsound minecraft:block.amethyst_block.chime player @a[distance=..24] ~ ~ ~ 0.72 1.8
execute if score @s oa.small matches 140 run playsound minecraft:block.amethyst_block.chime player @a[distance=..24] ~ ~ ~ 0.72 1.8
execute if score @s oa.small matches 100 run playsound minecraft:block.amethyst_block.chime player @a[distance=..24] ~ ~ ~ 0.72 1.8
execute if score @s oa.small matches 60 run playsound minecraft:block.amethyst_block.chime player @a[distance=..24] ~ ~ ~ 0.72 1.8
execute if score @s oa.small matches 20 run playsound minecraft:block.amethyst_block.chime player @a[distance=..24] ~ ~ ~ 0.72 1.8
