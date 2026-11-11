execute unless score #state oa.map2 matches 1 run return 0
execute unless score #state br.state matches 0 run return run function oa:map/pause
execute unless data storage oa_map2:job {holding:1b} run return run function oa:map/internal/job/next
function oa:map/internal/job/dispatch_wait with storage oa_map2:args
