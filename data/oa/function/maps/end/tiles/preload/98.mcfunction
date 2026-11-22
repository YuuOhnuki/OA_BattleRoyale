execute store success score #had0 oa.map2 run forceload query ~104 ~136
execute store success score #had1 oa.map2 run forceload query ~104 ~152
execute store success score #had2 oa.map2 run forceload query ~120 ~136
execute store success score #had3 oa.map2 run forceload query ~120 ~152
execute store success score #had4 oa.map2 run forceload query ~135 ~136
execute store success score #had5 oa.map2 run forceload query ~135 ~152
forceload add ~104 ~136 ~135 ~152
data modify storage oa_map2:job holding set value 1b
schedule function oa:map/internal/job/wait 1t replace
