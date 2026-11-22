execute if score #had0 oa.map2 matches 0 run forceload remove ~-24 ~136
execute if score #had1 oa.map2 matches 0 run forceload remove ~-24 ~152
execute if score #had2 oa.map2 matches 0 run forceload remove ~-8 ~136
execute if score #had3 oa.map2 matches 0 run forceload remove ~-8 ~152
execute if score #had4 oa.map2 matches 0 run forceload remove ~7 ~136
execute if score #had5 oa.map2 matches 0 run forceload remove ~7 ~152
data modify storage oa_map2:job holding set value 0b
