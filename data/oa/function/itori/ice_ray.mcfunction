execute unless block ^ ^0.9 ^0.5 #oa:push_passable run return 0
execute positioned ^ ^0.9 ^0.5 run function oa:itori/area_point
scoreboard players add #i_ice_ray oa.tmp 1
execute if score #i_ice_ray oa.tmp matches 2 run particle minecraft:snowflake ^ ^0.9 ^0.5 0.15 0.25 0.15 0.03 3 normal @a[distance=..24]
execute if score #i_ice_ray oa.tmp matches 6 run particle minecraft:cloud ^ ^0.9 ^0.5 0.15 0.25 0.15 0.01 2 normal @a[distance=..24]
execute if score #i_ice_ray oa.tmp matches ..7 positioned ^ ^ ^0.5 run function oa:itori/ice_ray
