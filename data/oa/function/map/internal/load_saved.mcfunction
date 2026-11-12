$execute if data storage oa:maps saved.$(key).center run data modify storage oa:br center set from storage oa:maps saved.$(key).center
$execute if data storage oa:maps saved.$(key).points run data modify storage oa:spawn_points points set from storage oa:maps saved.$(key).points
$execute if data storage oa:maps saved.$(key).spawn_dim run data modify storage oa:spawn_points dim set from storage oa:maps saved.$(key).spawn_dim
$execute if data storage oa:maps saved.$(key).args.center_y run data modify storage oa_map2:args set from storage oa:maps saved.$(key).args
$execute if data storage oa:maps saved.$(key).state store result score #state oa.map2 run data get storage oa:maps saved.$(key).state
