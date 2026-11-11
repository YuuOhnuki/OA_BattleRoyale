execute store success score #had0 oa.map2 run forceload query ~-152 ~72
execute store success score #had1 oa.map2 run forceload query ~-152 ~88
execute store success score #had2 oa.map2 run forceload query ~-152 ~103
execute store success score #had3 oa.map2 run forceload query ~-136 ~72
execute store success score #had4 oa.map2 run forceload query ~-136 ~88
execute store success score #had5 oa.map2 run forceload query ~-136 ~103
execute store success score #had6 oa.map2 run forceload query ~-121 ~72
execute store success score #had7 oa.map2 run forceload query ~-121 ~88
execute store success score #had8 oa.map2 run forceload query ~-121 ~103
forceload add ~-152 ~72 ~-121 ~103
data modify storage oa_map2:job holding set value 1b
schedule function oa:map/internal/job/wait 1t replace
