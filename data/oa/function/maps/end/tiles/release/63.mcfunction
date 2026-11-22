execute if score #had0 oa.map2 matches 0 run forceload remove ~-56 ~40
execute if score #had1 oa.map2 matches 0 run forceload remove ~-56 ~56
execute if score #had2 oa.map2 matches 0 run forceload remove ~-56 ~71
execute if score #had3 oa.map2 matches 0 run forceload remove ~-40 ~40
execute if score #had4 oa.map2 matches 0 run forceload remove ~-40 ~56
execute if score #had5 oa.map2 matches 0 run forceload remove ~-40 ~71
execute if score #had6 oa.map2 matches 0 run forceload remove ~-25 ~40
execute if score #had7 oa.map2 matches 0 run forceload remove ~-25 ~56
execute if score #had8 oa.map2 matches 0 run forceload remove ~-25 ~71
data modify storage oa_map2:job holding set value 0b
