execute store result storage oa:spawn_points args.index int 1 run scoreboard players get #point_index br.tmp
data modify storage oa:spawn_points args.x set from storage oa:spawn_points scan[0].x
data modify storage oa:spawn_points args.y set from storage oa:spawn_points scan[0].y
data modify storage oa:spawn_points args.z set from storage oa:spawn_points scan[0].z
execute at @s run function oa:br/spawn_points/remove_check with storage oa:spawn_points args
execute if score #point_removed br.flag matches 1 run return 1
data remove storage oa:spawn_points scan[0]
scoreboard players add #point_index br.tmp 1
execute if data storage oa:spawn_points scan[0] run function oa:br/spawn_points/remove_scan
