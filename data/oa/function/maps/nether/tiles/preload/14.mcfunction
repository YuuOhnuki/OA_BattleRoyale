execute if score #mode oa.map2 matches 2 run return run function oa:map/internal/job/skip_water
execute store success score #had0 oa.map2 run forceload query ~-24 ~-120
execute store success score #had1 oa.map2 run forceload query ~-24 ~-104
execute store success score #had2 oa.map2 run forceload query ~-24 ~-89
execute store success score #had3 oa.map2 run forceload query ~-8 ~-120
execute store success score #had4 oa.map2 run forceload query ~-8 ~-104
execute store success score #had5 oa.map2 run forceload query ~-8 ~-89
execute store success score #had6 oa.map2 run forceload query ~7 ~-120
execute store success score #had7 oa.map2 run forceload query ~7 ~-104
execute store success score #had8 oa.map2 run forceload query ~7 ~-89
forceload add ~-24 ~-120 ~7 ~-89
data modify storage oa_map2:job holding set value 1b
schedule function oa:map/internal/job/wait 1t replace
