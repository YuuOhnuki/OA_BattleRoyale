attribute @s minecraft:movement_speed modifier remove oa:staple_root
attribute @s minecraft:jump_strength modifier remove oa:staple_root
tag @s remove oa.stapled
scoreboard players set @s oa.root 0
scoreboard players set @s oa.bleed 0
scoreboard players set @s oa.bleed_by 0
execute store result storage oa:args id int 1 run scoreboard players get @s oa.id
function oa:hotchikisu/root_clear with storage oa:args
