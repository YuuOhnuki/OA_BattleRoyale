data modify storage oa:root_work pos set value {}
$data modify storage oa:root_work pos set from storage oa:roots p$(id)
execute if data storage oa:root_work pos.dim run function oa:hotchikisu/root_warp with storage oa:root_work pos
