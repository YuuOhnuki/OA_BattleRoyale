execute if score #mode oa.map2 matches 2 run return run function oa:map/internal/job/skip_water
execute store success score #had0 oa.map2 run forceload query ~72 ~-88
execute store success score #had1 oa.map2 run forceload query ~72 ~-72
execute store success score #had2 oa.map2 run forceload query ~72 ~-57
execute store success score #had3 oa.map2 run forceload query ~88 ~-88
execute store success score #had4 oa.map2 run forceload query ~88 ~-72
execute store success score #had5 oa.map2 run forceload query ~88 ~-57
execute store success score #had6 oa.map2 run forceload query ~103 ~-88
execute store success score #had7 oa.map2 run forceload query ~103 ~-72
execute store success score #had8 oa.map2 run forceload query ~103 ~-57
forceload add ~72 ~-88 ~103 ~-57
data modify storage oa_map2:job holding set value 1b
schedule function oa:map/internal/job/wait 1t replace
