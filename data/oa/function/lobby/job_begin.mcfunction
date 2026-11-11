data modify storage oa:lobby_job working set value 1b
execute unless data storage oa:lobby origin{ready:1b} run return run function oa:lobby/job_finish
data modify storage oa:lobby_job old set from storage oa:lobby origin
data modify storage oa:lobby origin.ready set value 0b
function oa:lobby/delete_preload with storage oa:lobby_job old
