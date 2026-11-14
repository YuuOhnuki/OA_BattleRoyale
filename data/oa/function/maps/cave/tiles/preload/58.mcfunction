execute if score #mode oa.map2 matches 2 run return run function oa:map/internal/job/skip_water
execute store success score #had0 oa.map2 run forceload query ~104 ~8
execute store success score #had1 oa.map2 run forceload query ~104 ~24
execute store success score #had2 oa.map2 run forceload query ~104 ~39
execute store success score #had3 oa.map2 run forceload query ~120 ~8
execute store success score #had4 oa.map2 run forceload query ~120 ~24
execute store success score #had5 oa.map2 run forceload query ~120 ~39
execute store success score #had6 oa.map2 run forceload query ~135 ~8
execute store success score #had7 oa.map2 run forceload query ~135 ~24
execute store success score #had8 oa.map2 run forceload query ~135 ~39
forceload add ~104 ~8 ~135 ~39
data modify storage oa_map2:job holding set value 1b
schedule function oa:map/internal/job/wait 1t replace
