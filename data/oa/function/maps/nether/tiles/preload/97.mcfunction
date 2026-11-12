execute store success score #had0 oa.map2 run forceload query ~72 ~136
execute store success score #had1 oa.map2 run forceload query ~72 ~152
execute store success score #had2 oa.map2 run forceload query ~88 ~136
execute store success score #had3 oa.map2 run forceload query ~88 ~152
execute store success score #had4 oa.map2 run forceload query ~103 ~136
execute store success score #had5 oa.map2 run forceload query ~103 ~152
forceload add ~72 ~136 ~103 ~152
data modify storage oa_map2:job holding set value 1b
schedule function oa:map/internal/job/wait 1t replace
