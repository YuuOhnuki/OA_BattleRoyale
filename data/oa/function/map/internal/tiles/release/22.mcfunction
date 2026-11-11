execute if score #had0 oa.map2 matches 0 run forceload remove ~-88 ~-88
execute if score #had1 oa.map2 matches 0 run forceload remove ~-88 ~-72
execute if score #had2 oa.map2 matches 0 run forceload remove ~-88 ~-57
execute if score #had3 oa.map2 matches 0 run forceload remove ~-72 ~-88
execute if score #had4 oa.map2 matches 0 run forceload remove ~-72 ~-72
execute if score #had5 oa.map2 matches 0 run forceload remove ~-72 ~-57
execute if score #had6 oa.map2 matches 0 run forceload remove ~-57 ~-88
execute if score #had7 oa.map2 matches 0 run forceload remove ~-57 ~-72
execute if score #had8 oa.map2 matches 0 run forceload remove ~-57 ~-57
data modify storage oa_map2:job holding set value 0b
