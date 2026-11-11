execute unless score #state oa.map2 matches 1 run return 0
execute if score #tile oa.map2 matches 100.. run return run function oa:map/internal/job/finish
execute unless score #state br.state matches 0 run return run function oa:map/pause
function oa:map/internal/job/dispatch_next with storage oa_map2:args
