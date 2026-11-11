data modify storage oa:lobby origin set value {ready:1b,gallery:1981}
execute store result storage oa:lobby origin.x int 1 run data get entity @s Pos[0]
execute store result storage oa:lobby origin.y int 1 run data get entity @s Pos[1]
execute store result storage oa:lobby origin.z int 1 run data get entity @s Pos[2]
kill @s
