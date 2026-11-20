tag @s remove oa.ambush_active
scoreboard players set @s oa.back 0
execute store result storage oa:args id int 1 run scoreboard players get @s oa.id
function oa:yuttari/forget_origin with storage oa:args
