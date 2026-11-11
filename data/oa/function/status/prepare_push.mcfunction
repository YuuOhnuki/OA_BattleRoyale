data modify storage oa:push yaw set from entity @s Rotation[0]
data modify storage oa:push pitch set from entity @s Rotation[1]
execute store result storage oa:args id int 1 run scoreboard players get @s oa.id
function oa:status/push_rotation with storage oa:args
