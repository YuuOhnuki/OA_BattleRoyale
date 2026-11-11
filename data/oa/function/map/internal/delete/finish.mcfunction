scoreboard players set #same_map_dim br.flag 0
execute if data storage oa_map2:args {dim:"oa:br"} if data storage oa:br center{dim:"oa:br"} run scoreboard players set #same_map_dim br.flag 1
execute if data storage oa_map2:args {dim:"minecraft:overworld"} if data storage oa:br center{dim:"minecraft:overworld"} run scoreboard players set #same_map_dim br.flag 1
data modify storage oa_map2:job working set value 0b
data modify storage oa_map2:job deleting set value 0b
scoreboard players set #state oa.map2 0
execute if score #same_map_dim br.flag matches 1 run data remove storage oa:br center
execute if score #same_map_dim br.flag matches 1 run data remove storage oa:br border_restore
data remove storage oa_map2:args center_y
tellraw @a[tag=br.admin] {text:"登録済みマップの削除が完了しました。",color:"green"}
