execute unless score @s oa.i_dive matches 1.. run return 0
execute at @s positioned ~ ~0.05 ~ run function oa:itori/dive_rise
scoreboard players remove #i_upsteps oa.tmp 1
execute if score @s oa.i_dive matches 1.. if score #i_upsteps oa.tmp matches 1.. run function oa:itori/dive_upstep
