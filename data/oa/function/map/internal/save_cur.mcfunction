$data remove storage oa:maps saved.$(key)
$data modify storage oa:maps saved.$(key).center set from storage oa:br center
$data modify storage oa:maps saved.$(key).points set from storage oa:spawn_points points
$data modify storage oa:maps saved.$(key).spawn_dim set from storage oa:spawn_points dim
$data modify storage oa:maps saved.$(key).args set from storage oa_map2:args
$execute store result storage oa:maps saved.$(key).state int 1 run scoreboard players get #state oa.map2
