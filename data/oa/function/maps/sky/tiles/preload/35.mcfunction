execute store success score #had0 oa.map2 run forceload query ~8 ~-56
execute store success score #had1 oa.map2 run forceload query ~8 ~-40
execute store success score #had2 oa.map2 run forceload query ~8 ~-25
execute store success score #had3 oa.map2 run forceload query ~24 ~-56
execute store success score #had4 oa.map2 run forceload query ~24 ~-40
execute store success score #had5 oa.map2 run forceload query ~24 ~-25
execute store success score #had6 oa.map2 run forceload query ~39 ~-56
execute store success score #had7 oa.map2 run forceload query ~39 ~-40
execute store success score #had8 oa.map2 run forceload query ~39 ~-25
forceload add ~8 ~-56 ~39 ~-25
data modify storage oa_map2:job holding set value 1b
schedule function oa:map/internal/job/wait 1t replace
