$data modify storage oa:finale d set from storage oa:maps defs.$(key)
data modify storage oa:finale d.x set from storage oa:finale a.x
data modify storage oa:finale d.z set from storage oa:finale a.z
execute unless data storage oa:finale d.finale run data modify storage oa:finale d.finale set value "oa:finale/default"
function oa:finale/exec with storage oa:finale d
