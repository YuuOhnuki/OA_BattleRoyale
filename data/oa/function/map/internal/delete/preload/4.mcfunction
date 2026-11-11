execute store success score #had0 oa.map2 run forceload query ~-24 ~-152
execute store success score #had1 oa.map2 run forceload query ~-24 ~-136
execute store success score #had2 oa.map2 run forceload query ~-24 ~-121
execute store success score #had3 oa.map2 run forceload query ~-8 ~-152
execute store success score #had4 oa.map2 run forceload query ~-8 ~-136
execute store success score #had5 oa.map2 run forceload query ~-8 ~-121
execute store success score #had6 oa.map2 run forceload query ~7 ~-152
execute store success score #had7 oa.map2 run forceload query ~7 ~-136
execute store success score #had8 oa.map2 run forceload query ~7 ~-121
forceload add ~-24 ~-152 ~7 ~-121
data modify storage oa_map2:job holding set value 1b
schedule function oa:map/internal/delete/wait 1t replace
