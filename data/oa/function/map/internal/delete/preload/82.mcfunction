execute store success score #had0 oa.map2 run forceload query ~-88 ~104
execute store success score #had1 oa.map2 run forceload query ~-88 ~120
execute store success score #had2 oa.map2 run forceload query ~-88 ~135
execute store success score #had3 oa.map2 run forceload query ~-72 ~104
execute store success score #had4 oa.map2 run forceload query ~-72 ~120
execute store success score #had5 oa.map2 run forceload query ~-72 ~135
execute store success score #had6 oa.map2 run forceload query ~-57 ~104
execute store success score #had7 oa.map2 run forceload query ~-57 ~120
execute store success score #had8 oa.map2 run forceload query ~-57 ~135
forceload add ~-88 ~104 ~-57 ~135
data modify storage oa_map2:job holding set value 1b
schedule function oa:map/internal/delete/wait 1t replace
