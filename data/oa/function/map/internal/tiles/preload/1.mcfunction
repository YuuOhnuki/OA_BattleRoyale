execute if score #mode oa.map2 matches 2 run return run function oa:map/internal/job/skip_water
execute store success score #had0 oa.map2 run forceload query ~-120 ~-152
execute store success score #had1 oa.map2 run forceload query ~-120 ~-136
execute store success score #had2 oa.map2 run forceload query ~-120 ~-121
execute store success score #had3 oa.map2 run forceload query ~-104 ~-152
execute store success score #had4 oa.map2 run forceload query ~-104 ~-136
execute store success score #had5 oa.map2 run forceload query ~-104 ~-121
execute store success score #had6 oa.map2 run forceload query ~-89 ~-152
execute store success score #had7 oa.map2 run forceload query ~-89 ~-136
execute store success score #had8 oa.map2 run forceload query ~-89 ~-121
forceload add ~-120 ~-152 ~-89 ~-121
data modify storage oa_map2:job holding set value 1b
schedule function oa:map/internal/job/wait 1t replace
