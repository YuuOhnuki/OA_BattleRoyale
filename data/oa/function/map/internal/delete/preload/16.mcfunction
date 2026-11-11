execute store success score #had0 oa.map2 run forceload query ~40 ~-120
execute store success score #had1 oa.map2 run forceload query ~40 ~-104
execute store success score #had2 oa.map2 run forceload query ~40 ~-89
execute store success score #had3 oa.map2 run forceload query ~56 ~-120
execute store success score #had4 oa.map2 run forceload query ~56 ~-104
execute store success score #had5 oa.map2 run forceload query ~56 ~-89
execute store success score #had6 oa.map2 run forceload query ~71 ~-120
execute store success score #had7 oa.map2 run forceload query ~71 ~-104
execute store success score #had8 oa.map2 run forceload query ~71 ~-89
forceload add ~40 ~-120 ~71 ~-89
data modify storage oa_map2:job holding set value 1b
schedule function oa:map/internal/delete/wait 1t replace
