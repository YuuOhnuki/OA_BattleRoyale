execute store success score #had0 oa.map2 run forceload query ~8 ~8
execute store success score #had1 oa.map2 run forceload query ~8 ~24
execute store success score #had2 oa.map2 run forceload query ~8 ~39
execute store success score #had3 oa.map2 run forceload query ~24 ~8
execute store success score #had4 oa.map2 run forceload query ~24 ~24
execute store success score #had5 oa.map2 run forceload query ~24 ~39
execute store success score #had6 oa.map2 run forceload query ~39 ~8
execute store success score #had7 oa.map2 run forceload query ~39 ~24
execute store success score #had8 oa.map2 run forceload query ~39 ~39
forceload add ~8 ~8 ~39 ~39
data modify storage oa_map2:job holding set value 1b
schedule function oa:map/internal/delete/wait 1t replace
