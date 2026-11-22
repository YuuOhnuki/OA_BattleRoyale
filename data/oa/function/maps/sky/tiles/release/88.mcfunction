execute if score #had0 oa.map2 matches 0 run forceload remove ~104 ~104
execute if score #had1 oa.map2 matches 0 run forceload remove ~104 ~120
execute if score #had2 oa.map2 matches 0 run forceload remove ~104 ~135
execute if score #had3 oa.map2 matches 0 run forceload remove ~120 ~104
execute if score #had4 oa.map2 matches 0 run forceload remove ~120 ~120
execute if score #had5 oa.map2 matches 0 run forceload remove ~120 ~135
execute if score #had6 oa.map2 matches 0 run forceload remove ~135 ~104
execute if score #had7 oa.map2 matches 0 run forceload remove ~135 ~120
execute if score #had8 oa.map2 matches 0 run forceload remove ~135 ~135
data modify storage oa_map2:job holding set value 0b
