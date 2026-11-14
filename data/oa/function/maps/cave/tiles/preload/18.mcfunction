execute if score #mode oa.map2 matches 2 run return run function oa:map/internal/job/skip_water
execute store success score #had0 oa.map2 run forceload query ~104 ~-120
execute store success score #had1 oa.map2 run forceload query ~104 ~-104
execute store success score #had2 oa.map2 run forceload query ~104 ~-89
execute store success score #had3 oa.map2 run forceload query ~120 ~-120
execute store success score #had4 oa.map2 run forceload query ~120 ~-104
execute store success score #had5 oa.map2 run forceload query ~120 ~-89
execute store success score #had6 oa.map2 run forceload query ~135 ~-120
execute store success score #had7 oa.map2 run forceload query ~135 ~-104
execute store success score #had8 oa.map2 run forceload query ~135 ~-89
forceload add ~104 ~-120 ~135 ~-89
data modify storage oa_map2:job holding set value 1b
schedule function oa:map/internal/job/wait 1t replace
