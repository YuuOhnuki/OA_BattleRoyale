execute store success score #had0 oa.map2 run forceload query ~-56 ~72
execute store success score #had1 oa.map2 run forceload query ~-56 ~88
execute store success score #had2 oa.map2 run forceload query ~-56 ~103
execute store success score #had3 oa.map2 run forceload query ~-40 ~72
execute store success score #had4 oa.map2 run forceload query ~-40 ~88
execute store success score #had5 oa.map2 run forceload query ~-40 ~103
execute store success score #had6 oa.map2 run forceload query ~-25 ~72
execute store success score #had7 oa.map2 run forceload query ~-25 ~88
execute store success score #had8 oa.map2 run forceload query ~-25 ~103
forceload add ~-56 ~72 ~-25 ~103
data modify storage oa_map2:job holding set value 1b
schedule function oa:map/internal/delete/wait 1t replace
