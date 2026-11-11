scoreboard players set #state oa.map2 1
scoreboard players set #tile oa.map2 0
scoreboard players set #chests oa.map2 0
scoreboard players set #ores oa.map2 0
data modify storage oa_map2:args tile set value 0
data modify storage oa_map2:job working set value 1b
tellraw @a {text:"[OA Map 305] 処理開始。完了まで試合を開始しないでください。全100区画",color:"gold"}
function oa:map/internal/job/next
