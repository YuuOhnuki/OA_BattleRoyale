execute unless entity @s[tag=br.alive] run return run scoreboard players set @s oa.i_burn 0
scoreboard players remove @s oa.i_burn 1
particle minecraft:flame ~ ~0.8 ~ 0.25 0.5 0.25 0.01 2 normal @a[distance=..24]
execute if score @s oa.i_burn matches 40 run function oa:itori/burn_damage
execute if score @s oa.i_burn matches 20 run function oa:itori/burn_damage
execute if score @s oa.i_burn matches 0 run function oa:itori/burn_damage
