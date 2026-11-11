execute if score #mode oa.map2 matches 2 run return run function oa:map/internal/job/skip_water
execute store success score #had0 oa.map2 run forceload query ~104 ~40
execute store success score #had1 oa.map2 run forceload query ~104 ~56
execute store success score #had2 oa.map2 run forceload query ~104 ~71
execute store success score #had3 oa.map2 run forceload query ~120 ~40
execute store success score #had4 oa.map2 run forceload query ~120 ~56
execute store success score #had5 oa.map2 run forceload query ~120 ~71
execute store success score #had6 oa.map2 run forceload query ~135 ~40
execute store success score #had7 oa.map2 run forceload query ~135 ~56
execute store success score #had8 oa.map2 run forceload query ~135 ~71
forceload add ~104 ~40 ~135 ~71
data modify storage oa_map2:job holding set value 1b
schedule function oa:map/internal/job/wait 1t replace
