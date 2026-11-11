execute store success score #had0 oa.map2 run forceload query ~-56 ~-152
execute store success score #had1 oa.map2 run forceload query ~-56 ~-136
execute store success score #had2 oa.map2 run forceload query ~-56 ~-121
execute store success score #had3 oa.map2 run forceload query ~-40 ~-152
execute store success score #had4 oa.map2 run forceload query ~-40 ~-136
execute store success score #had5 oa.map2 run forceload query ~-40 ~-121
execute store success score #had6 oa.map2 run forceload query ~-25 ~-152
execute store success score #had7 oa.map2 run forceload query ~-25 ~-136
execute store success score #had8 oa.map2 run forceload query ~-25 ~-121
forceload add ~-56 ~-152 ~-25 ~-121
data modify storage oa_map2:job holding set value 1b
schedule function oa:map/internal/delete/wait 1t replace
