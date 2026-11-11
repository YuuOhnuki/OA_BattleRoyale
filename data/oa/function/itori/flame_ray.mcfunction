execute unless block ^ ^0.9 ^0.5 #oa:push_passable run return 0
execute positioned ^ ^0.9 ^0.5 run function oa:itori/flame_point
scoreboard players add #i_flame_ray oa.tmp 1
execute if score #i_flame_ray oa.tmp matches 8 run particle minecraft:flame ^ ^0.9 ^0.5 0.05 0.2 0.05 0.02 2 normal @a[distance=..28]
execute if score #i_flame_ray oa.tmp matches 12 run particle minecraft:lava ^ ^0.8 ^0.5 0.06 0.06 0.06 0 1 normal @a[distance=..28]
execute if score #i_flame_ray oa.tmp matches ..11 positioned ^ ^ ^0.5 run function oa:itori/flame_ray
