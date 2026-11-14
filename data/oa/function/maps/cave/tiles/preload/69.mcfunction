execute if score #mode oa.map2 matches 2 run return run function oa:map/internal/job/skip_water
execute store success score #had0 oa.map2 run forceload query ~136 ~40
execute store success score #had1 oa.map2 run forceload query ~136 ~56
execute store success score #had2 oa.map2 run forceload query ~136 ~71
execute store success score #had3 oa.map2 run forceload query ~152 ~40
execute store success score #had4 oa.map2 run forceload query ~152 ~56
execute store success score #had5 oa.map2 run forceload query ~152 ~71
forceload add ~136 ~40 ~152 ~71
data modify storage oa_map2:job holding set value 1b
schedule function oa:map/internal/job/wait 1t replace
