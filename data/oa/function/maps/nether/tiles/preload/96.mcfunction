execute store success score #had0 oa.map2 run forceload query ~40 ~136
execute store success score #had1 oa.map2 run forceload query ~40 ~152
execute store success score #had2 oa.map2 run forceload query ~56 ~136
execute store success score #had3 oa.map2 run forceload query ~56 ~152
execute store success score #had4 oa.map2 run forceload query ~71 ~136
execute store success score #had5 oa.map2 run forceload query ~71 ~152
forceload add ~40 ~136 ~71 ~152
data modify storage oa_map2:job holding set value 1b
schedule function oa:map/internal/job/wait 1t replace
