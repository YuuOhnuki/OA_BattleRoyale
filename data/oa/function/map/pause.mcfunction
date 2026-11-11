execute unless score #state oa.map2 matches 1 run return 0
schedule clear oa:map/internal/job/next
schedule clear oa:map/internal/job/wait
execute if data storage oa_map2:job {holding:1b} run function oa:map/internal/job/dispatch_release with storage oa_map2:args
scoreboard players set #state oa.map2 2
tellraw @a {text:"[OA Map 305] 停止しました。再開は /function oa:map/resume",color:"yellow"}
