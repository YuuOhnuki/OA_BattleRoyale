execute store success score #had0 oa.map2 run forceload query ~-152 ~-24
execute store success score #had1 oa.map2 run forceload query ~-152 ~-8
execute store success score #had2 oa.map2 run forceload query ~-152 ~7
execute store success score #had3 oa.map2 run forceload query ~-136 ~-24
execute store success score #had4 oa.map2 run forceload query ~-136 ~-8
execute store success score #had5 oa.map2 run forceload query ~-136 ~7
execute store success score #had6 oa.map2 run forceload query ~-121 ~-24
execute store success score #had7 oa.map2 run forceload query ~-121 ~-8
execute store success score #had8 oa.map2 run forceload query ~-121 ~7
forceload add ~-152 ~-24 ~-121 ~7
data modify storage oa_map2:job holding set value 1b
schedule function oa:map/internal/delete/wait 1t replace
