attribute @s minecraft:gravity modifier remove oa:itori_dive
attribute @s minecraft:fall_damage_multiplier modifier remove oa:itori_dive
scoreboard players set @s oa.i_dive 0
execute store result storage oa:itori id int 1 run scoreboard players get @s oa.id
function oa:itori/dive_remove with storage oa:itori
