execute if score #had0 oa.map2 matches 0 run forceload remove ~-152 ~-152
execute if score #had1 oa.map2 matches 0 run forceload remove ~-152 ~-136
execute if score #had2 oa.map2 matches 0 run forceload remove ~-152 ~-121
execute if score #had3 oa.map2 matches 0 run forceload remove ~-136 ~-152
execute if score #had4 oa.map2 matches 0 run forceload remove ~-136 ~-136
execute if score #had5 oa.map2 matches 0 run forceload remove ~-136 ~-121
execute if score #had6 oa.map2 matches 0 run forceload remove ~-121 ~-152
execute if score #had7 oa.map2 matches 0 run forceload remove ~-121 ~-136
execute if score #had8 oa.map2 matches 0 run forceload remove ~-121 ~-121
data modify storage oa_map2:job holding set value 0b
