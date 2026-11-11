execute store success score #had0 oa.map2 run forceload query ~-120 ~-24
execute store success score #had1 oa.map2 run forceload query ~-120 ~-8
execute store success score #had2 oa.map2 run forceload query ~-120 ~7
execute store success score #had3 oa.map2 run forceload query ~-104 ~-24
execute store success score #had4 oa.map2 run forceload query ~-104 ~-8
execute store success score #had5 oa.map2 run forceload query ~-104 ~7
execute store success score #had6 oa.map2 run forceload query ~-89 ~-24
execute store success score #had7 oa.map2 run forceload query ~-89 ~-8
execute store success score #had8 oa.map2 run forceload query ~-89 ~7
forceload add ~-120 ~-24 ~-89 ~7
data modify storage oa_map2:job holding set value 1b
schedule function oa:map/internal/job/wait 1t replace
