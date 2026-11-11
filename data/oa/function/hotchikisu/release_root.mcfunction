attribute @s minecraft:movement_speed modifier remove oa:staple_root
attribute @s minecraft:jump_strength modifier remove oa:staple_root
tag @s remove oa.stapled
execute store result storage oa:args id int 1 run scoreboard players get @s oa.id
function oa:hotchikisu/root_clear with storage oa:args
