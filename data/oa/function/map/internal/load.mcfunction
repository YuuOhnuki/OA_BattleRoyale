execute if data storage oa_map2:args center_y unless data storage oa_map2:args dim run data modify storage oa_map2:args dim set value "minecraft:overworld"
scoreboard objectives add oa.map2 dummy
scoreboard players add #state oa.map2 0
schedule clear oa:map/internal/job/next
schedule clear oa:map/internal/job/wait
execute if score #state oa.map2 matches 1 run schedule function oa:map/internal/job/wait 2t replace
execute if score #state oa.map2 matches 4 if data storage oa_map2:job {holding:1b} run schedule function oa:map/internal/delete/wait 2t replace
execute if score #state oa.map2 matches 4 unless data storage oa_map2:job {holding:1b} run schedule function oa:map/internal/delete/dispatch 2t replace
