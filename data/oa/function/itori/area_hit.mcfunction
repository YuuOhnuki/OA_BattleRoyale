execute if score @s oa.i_stamp = #i_stamp oa.tmp run return 0
scoreboard players operation @s oa.i_stamp = #i_stamp oa.tmp
tag @s add oa.i_struck
function oa:combat/gated_damage
execute if score @s oa.blocked matches 0 if score #i_status oa.tmp matches 1 run effect give @s minecraft:slowness 3 0 true
execute if score @s oa.blocked matches 0 if score #i_status oa.tmp matches 2 run function oa:itori/burn_start
