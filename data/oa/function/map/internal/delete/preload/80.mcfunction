execute store success score #had0 oa.map2 run forceload query ~-152 ~104
execute store success score #had1 oa.map2 run forceload query ~-152 ~120
execute store success score #had2 oa.map2 run forceload query ~-152 ~135
execute store success score #had3 oa.map2 run forceload query ~-136 ~104
execute store success score #had4 oa.map2 run forceload query ~-136 ~120
execute store success score #had5 oa.map2 run forceload query ~-136 ~135
execute store success score #had6 oa.map2 run forceload query ~-121 ~104
execute store success score #had7 oa.map2 run forceload query ~-121 ~120
execute store success score #had8 oa.map2 run forceload query ~-121 ~135
forceload add ~-152 ~104 ~-121 ~135
data modify storage oa_map2:job holding set value 1b
schedule function oa:map/internal/delete/wait 1t replace
