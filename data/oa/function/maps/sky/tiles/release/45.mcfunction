execute if score #had0 oa.map2 matches 0 run forceload remove ~8 ~-24
execute if score #had1 oa.map2 matches 0 run forceload remove ~8 ~-8
execute if score #had2 oa.map2 matches 0 run forceload remove ~8 ~7
execute if score #had3 oa.map2 matches 0 run forceload remove ~24 ~-24
execute if score #had4 oa.map2 matches 0 run forceload remove ~24 ~-8
execute if score #had5 oa.map2 matches 0 run forceload remove ~24 ~7
execute if score #had6 oa.map2 matches 0 run forceload remove ~39 ~-24
execute if score #had7 oa.map2 matches 0 run forceload remove ~39 ~-8
execute if score #had8 oa.map2 matches 0 run forceload remove ~39 ~7
data modify storage oa_map2:job holding set value 0b
