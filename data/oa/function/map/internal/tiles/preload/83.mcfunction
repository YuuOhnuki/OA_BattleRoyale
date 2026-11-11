execute store success score #had0 oa.map2 run forceload query ~-56 ~104
execute store success score #had1 oa.map2 run forceload query ~-56 ~120
execute store success score #had2 oa.map2 run forceload query ~-56 ~135
execute store success score #had3 oa.map2 run forceload query ~-40 ~104
execute store success score #had4 oa.map2 run forceload query ~-40 ~120
execute store success score #had5 oa.map2 run forceload query ~-40 ~135
execute store success score #had6 oa.map2 run forceload query ~-25 ~104
execute store success score #had7 oa.map2 run forceload query ~-25 ~120
execute store success score #had8 oa.map2 run forceload query ~-25 ~135
forceload add ~-56 ~104 ~-25 ~135
data modify storage oa_map2:job holding set value 1b
schedule function oa:map/internal/job/wait 1t replace
