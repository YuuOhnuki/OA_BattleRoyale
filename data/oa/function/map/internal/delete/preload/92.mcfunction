execute store success score #had0 oa.map2 run forceload query ~-88 ~136
execute store success score #had1 oa.map2 run forceload query ~-88 ~152
execute store success score #had2 oa.map2 run forceload query ~-72 ~136
execute store success score #had3 oa.map2 run forceload query ~-72 ~152
execute store success score #had4 oa.map2 run forceload query ~-57 ~136
execute store success score #had5 oa.map2 run forceload query ~-57 ~152
forceload add ~-88 ~136 ~-57 ~152
data modify storage oa_map2:job holding set value 1b
schedule function oa:map/internal/delete/wait 1t replace
