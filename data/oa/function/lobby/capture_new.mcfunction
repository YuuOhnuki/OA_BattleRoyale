data modify storage oa:lobby_job new set value {}
execute store result storage oa:lobby_job new.x int 1 run data get entity @s Pos[0]
execute store result storage oa:lobby_job new.y int 1 run data get entity @s Pos[1]
execute store result storage oa:lobby_job new.z int 1 run data get entity @s Pos[2]
kill @s
