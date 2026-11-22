execute if score #mode oa.map2 matches 0 run function oa:maps/sky/tiles/place/27
execute if score #state oa.map2 matches 2 run return 0
execute positioned ~72 ~-40 ~-88 run kill @e[type=minecraft:marker,tag=br.chest,dx=31,dy=80,dz=31]
execute positioned ~72 ~-40 ~-88 run kill @e[type=minecraft:marker,tag=br.ore,dx=31,dy=80,dz=31]
execute positioned ~72 ~-40 ~-88 run kill @e[type=minecraft:marker,tag=oa.gim,dx=31,dy=80,dz=31]
execute positioned ~72 ~-40 ~-88 run kill @e[type=minecraft:block_display,tag=oa.mdeco,dx=31,dy=80,dz=31]
execute if score #mode oa.map2 matches 0 positioned ~72 ~-40 ~-88 run kill @e[type=minecraft:block_display,tag=oa.isle,dx=31,dy=80,dz=31]
scoreboard players set #stage oa.map2 2
scoreboard players set #localc oa.map2 0
scoreboard players set #localo oa.map2 0
scoreboard players set #expectedc oa.map2 0
scoreboard players set #expectedo oa.map2 0
execute positioned ~84 ~22 ~-70 align xyz positioned ~0.5 ~0 ~0.5 run summon minecraft:block_display ~ ~ ~ {Tags:["oa.mdeco"],block_state:"minecraft:dark_oak_planks",view_range:6.0f,Rotation:[210.0f,0.0f],transformation:{translation:[-1.500f,0.000f,-5.000f],left_rotation:[0.0f,0.0f,0.0f,1.0f],scale:[3.000f,1.600f,10.000f],right_rotation:[0.0f,0.0f,0.0f,1.0f]}}
execute positioned ~84 ~22 ~-70 align xyz positioned ~0.5 ~0 ~0.5 run summon minecraft:block_display ~ ~ ~ {Tags:["oa.mdeco"],block_state:"minecraft:dark_oak_planks",view_range:6.0f,Rotation:[210.0f,0.0f],transformation:{translation:[-1.000f,-0.600f,-6.000f],left_rotation:[0.0f,0.0f,0.0f,1.0f],scale:[2.000f,1.000f,12.000f],right_rotation:[0.0f,0.0f,0.0f,1.0f]}}
execute positioned ~84 ~22 ~-70 align xyz positioned ~0.5 ~0 ~0.5 run summon minecraft:block_display ~ ~ ~ {Tags:["oa.mdeco"],block_state:"minecraft:spruce_planks",view_range:6.0f,Rotation:[210.0f,0.0f],transformation:{translation:[-1.700f,1.600f,-5.200f],left_rotation:[0.0f,0.0f,0.0f,1.0f],scale:[3.400f,0.250f,10.400f],right_rotation:[0.0f,0.0f,0.0f,1.0f]}}
execute positioned ~84 ~22 ~-70 align xyz positioned ~0.5 ~0 ~0.5 run summon minecraft:block_display ~ ~ ~ {Tags:["oa.mdeco"],block_state:"minecraft:white_wool",view_range:6.0f,Rotation:[210.0f,0.0f],transformation:{translation:[-2.500f,4.800f,-6.500f],left_rotation:[0.0f,0.0f,0.0f,1.0f],scale:[5.000f,4.500f,13.000f],right_rotation:[0.0f,0.0f,0.0f,1.0f]}}
execute positioned ~84 ~22 ~-70 align xyz positioned ~0.5 ~0 ~0.5 run summon minecraft:block_display ~ ~ ~ {Tags:["oa.mdeco"],block_state:"minecraft:white_wool",view_range:6.0f,Rotation:[210.0f,0.0f],transformation:{translation:[-1.800f,5.500f,-7.500f],left_rotation:[0.0f,0.0f,0.0f,1.0f],scale:[3.600f,3.000f,15.000f],right_rotation:[0.0f,0.0f,0.0f,1.0f]}}
execute positioned ~84 ~22 ~-70 align xyz positioned ~0.5 ~0 ~0.5 run summon minecraft:block_display ~ ~ ~ {Tags:["oa.mdeco"],block_state:"minecraft:blue_wool",view_range:6.0f,Rotation:[210.0f,0.0f],transformation:{translation:[-2.600f,6.200f,-6.600f],left_rotation:[0.0f,0.0f,0.0f,1.0f],scale:[5.200f,0.800f,13.200f],right_rotation:[0.0f,0.0f,0.0f,1.0f]}}
execute positioned ~84 ~22 ~-70 align xyz positioned ~0.5 ~0 ~0.5 run summon minecraft:block_display ~ ~ ~ {Tags:["oa.mdeco"],block_state:"minecraft:blue_wool",view_range:6.0f,Rotation:[210.0f,0.0f],transformation:{translation:[-0.150f,4.600f,-8.200f],left_rotation:[0.0f,0.0f,0.0f,1.0f],scale:[0.300f,2.600f,2.400f],right_rotation:[0.0f,0.0f,0.0f,1.0f]}}
execute positioned ~84 ~22 ~-70 align xyz positioned ~0.5 ~0 ~0.5 run summon minecraft:block_display ~ ~ ~ {Tags:["oa.mdeco"],block_state:"minecraft:blue_wool",view_range:6.0f,Rotation:[210.0f,0.0f],transformation:{translation:[-1.700f,5.600f,-8.200f],left_rotation:[0.0f,0.0f,0.0f,1.0f],scale:[3.400f,0.300f,2.400f],right_rotation:[0.0f,0.0f,0.0f,1.0f]}}
execute unless score #localc oa.map2 = #expectedc oa.map2 run return run function oa:map/internal/job/failed
execute unless score #localo oa.map2 = #expectedo oa.map2 run return run function oa:map/internal/job/failed
scoreboard players operation #chests oa.map2 += #localc oa.map2
scoreboard players operation #ores oa.map2 += #localo oa.map2
function oa:maps/sky/tiles/release/27
scoreboard players add #tile oa.map2 1
execute store result storage oa_map2:args tile int 1 run scoreboard players get #tile oa.map2
execute if score #tile oa.map2 matches 100.. run return run function oa:map/internal/job/finish
schedule function oa:map/internal/job/next 1t replace
