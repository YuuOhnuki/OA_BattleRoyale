execute unless loaded ~ ~ ~ run return 0
execute if block ~ ~-0.1 ~ #oa:push_passable if score #i_ground_steps oa.tmp matches 1.. run return run function oa:itori/dive_lower
execute if block ~ ~-0.1 ~ #oa:push_passable run return 0
function oa:itori/jump_check
execute if score #i_clear oa.tmp matches 1 run tag @s add oa.dive_valid
execute if score #i_clear oa.tmp matches 1 run tp @s ~ ~ ~
