execute store success score #had0 oa.map2 run forceload query ~72 ~8
execute store success score #had1 oa.map2 run forceload query ~72 ~24
execute store success score #had2 oa.map2 run forceload query ~72 ~39
execute store success score #had3 oa.map2 run forceload query ~88 ~8
execute store success score #had4 oa.map2 run forceload query ~88 ~24
execute store success score #had5 oa.map2 run forceload query ~88 ~39
execute store success score #had6 oa.map2 run forceload query ~103 ~8
execute store success score #had7 oa.map2 run forceload query ~103 ~24
execute store success score #had8 oa.map2 run forceload query ~103 ~39
forceload add ~72 ~8 ~103 ~39
data modify storage oa_map2:job holding set value 1b
schedule function oa:map/internal/delete/wait 1t replace
