data remove storage oa:spawn_pool selected
$data modify storage oa:spawn_pool selected set from storage oa:spawn_pool points[$(index)]
$data remove storage oa:spawn_pool points[$(index)]

