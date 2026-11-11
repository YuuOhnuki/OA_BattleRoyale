$execute if entity @e[type=minecraft:marker,tag=oa.i_dive_goal,scores={oa.owner=$(id)},distance=..0.28] run return run function oa:itori/dive_impact
execute positioned ^ ^ ^0.25 run function oa:itori/jump_check
execute unless score #i_clear oa.tmp matches 1 run return run function oa:itori/dive_obstructed
execute positioned ^ ^ ^0.25 run tp @s ~ ~ ~
