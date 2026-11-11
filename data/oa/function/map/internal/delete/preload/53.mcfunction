execute store success score #had0 oa.map2 run forceload query ~-56 ~8
execute store success score #had1 oa.map2 run forceload query ~-56 ~24
execute store success score #had2 oa.map2 run forceload query ~-56 ~39
execute store success score #had3 oa.map2 run forceload query ~-40 ~8
execute store success score #had4 oa.map2 run forceload query ~-40 ~24
execute store success score #had5 oa.map2 run forceload query ~-40 ~39
execute store success score #had6 oa.map2 run forceload query ~-25 ~8
execute store success score #had7 oa.map2 run forceload query ~-25 ~24
execute store success score #had8 oa.map2 run forceload query ~-25 ~39
forceload add ~-56 ~8 ~-25 ~39
data modify storage oa_map2:job holding set value 1b
schedule function oa:map/internal/delete/wait 1t replace
