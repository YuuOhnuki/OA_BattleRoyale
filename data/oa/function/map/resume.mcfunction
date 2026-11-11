execute if data storage oa_map2:job {deleting:1b} run return 0
execute unless score #state oa.map2 matches 2 run return 0
execute unless score #state br.state matches 0 run return 0
scoreboard players set #state oa.map2 1
function oa:map/internal/job/next
