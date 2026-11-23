schedule clear oa:map/internal/job/next
schedule clear oa:map/internal/job/wait
execute if data storage oa_map2:job {holding:1b} run function oa:map/internal/job/dispatch_release with storage oa_map2:args
data modify storage oa_map2:job working set value 0b
