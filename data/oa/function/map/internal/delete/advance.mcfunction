execute store result score #delete_tile oa.map2 run data get storage oa_map2:args tile
scoreboard players add #delete_tile oa.map2 1
execute store result storage oa_map2:args tile int 1 run scoreboard players get #delete_tile oa.map2
execute if score #delete_tile oa.map2 matches 100.. run return run function oa:map/internal/delete/finish
schedule function oa:map/internal/delete/dispatch 1t replace
