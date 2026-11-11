execute store success score #had0 oa.map2 run forceload query ~72 ~-56
execute store success score #had1 oa.map2 run forceload query ~72 ~-40
execute store success score #had2 oa.map2 run forceload query ~72 ~-25
execute store success score #had3 oa.map2 run forceload query ~88 ~-56
execute store success score #had4 oa.map2 run forceload query ~88 ~-40
execute store success score #had5 oa.map2 run forceload query ~88 ~-25
execute store success score #had6 oa.map2 run forceload query ~103 ~-56
execute store success score #had7 oa.map2 run forceload query ~103 ~-40
execute store success score #had8 oa.map2 run forceload query ~103 ~-25
forceload add ~72 ~-56 ~103 ~-25
data modify storage oa_map2:job holding set value 1b
schedule function oa:map/internal/delete/wait 1t replace
