execute if score #mode oa.map2 matches 2 run return run function oa:map/internal/job/skip_water
execute store success score #had0 oa.map2 run forceload query ~-24 ~40
execute store success score #had1 oa.map2 run forceload query ~-24 ~56
execute store success score #had2 oa.map2 run forceload query ~-24 ~71
execute store success score #had3 oa.map2 run forceload query ~-8 ~40
execute store success score #had4 oa.map2 run forceload query ~-8 ~56
execute store success score #had5 oa.map2 run forceload query ~-8 ~71
execute store success score #had6 oa.map2 run forceload query ~7 ~40
execute store success score #had7 oa.map2 run forceload query ~7 ~56
execute store success score #had8 oa.map2 run forceload query ~7 ~71
forceload add ~-24 ~40 ~7 ~71
data modify storage oa_map2:job holding set value 1b
schedule function oa:map/internal/job/wait 1t replace
