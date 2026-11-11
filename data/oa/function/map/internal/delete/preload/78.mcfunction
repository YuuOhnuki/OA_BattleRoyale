execute store success score #had0 oa.map2 run forceload query ~104 ~72
execute store success score #had1 oa.map2 run forceload query ~104 ~88
execute store success score #had2 oa.map2 run forceload query ~104 ~103
execute store success score #had3 oa.map2 run forceload query ~120 ~72
execute store success score #had4 oa.map2 run forceload query ~120 ~88
execute store success score #had5 oa.map2 run forceload query ~120 ~103
execute store success score #had6 oa.map2 run forceload query ~135 ~72
execute store success score #had7 oa.map2 run forceload query ~135 ~88
execute store success score #had8 oa.map2 run forceload query ~135 ~103
forceload add ~104 ~72 ~135 ~103
data modify storage oa_map2:job holding set value 1b
schedule function oa:map/internal/delete/wait 1t replace
