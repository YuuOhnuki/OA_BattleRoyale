execute store success score #had0 oa.map2 run forceload query ~8 ~72
execute store success score #had1 oa.map2 run forceload query ~8 ~88
execute store success score #had2 oa.map2 run forceload query ~8 ~103
execute store success score #had3 oa.map2 run forceload query ~24 ~72
execute store success score #had4 oa.map2 run forceload query ~24 ~88
execute store success score #had5 oa.map2 run forceload query ~24 ~103
execute store success score #had6 oa.map2 run forceload query ~39 ~72
execute store success score #had7 oa.map2 run forceload query ~39 ~88
execute store success score #had8 oa.map2 run forceload query ~39 ~103
forceload add ~8 ~72 ~39 ~103
data modify storage oa_map2:job holding set value 1b
schedule function oa:map/internal/delete/wait 1t replace
