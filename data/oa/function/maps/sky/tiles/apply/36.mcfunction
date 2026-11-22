execute if score #mode oa.map2 matches 0 run function oa:maps/sky/tiles/place/36
execute if score #state oa.map2 matches 2 run return 0
execute positioned ~40 ~-40 ~-56 run kill @e[type=minecraft:marker,tag=br.chest,dx=31,dy=80,dz=31]
execute positioned ~40 ~-40 ~-56 run kill @e[type=minecraft:marker,tag=br.ore,dx=31,dy=80,dz=31]
execute positioned ~40 ~-40 ~-56 run kill @e[type=minecraft:marker,tag=oa.gim,dx=31,dy=80,dz=31]
execute positioned ~40 ~-40 ~-56 run kill @e[type=minecraft:block_display,tag=oa.mdeco,dx=31,dy=80,dz=31]
execute if score #mode oa.map2 matches 0 positioned ~40 ~-40 ~-56 run kill @e[type=minecraft:block_display,tag=oa.isle,dx=31,dy=80,dz=31]
scoreboard players set #stage oa.map2 2
scoreboard players set #localc oa.map2 0
scoreboard players set #localo oa.map2 0
scoreboard players set #expectedc oa.map2 1
scoreboard players set #expectedo oa.map2 0
execute positioned ~58 ~-25 ~-45 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #mode oa.map2 matches 0 positioned ~58 ~-25 ~-45 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute positioned ~60 ~-25 ~-43 align xyz positioned ~0.5 ~0 ~0.5 run summon minecraft:marker ~ ~ ~ {Tags:["oa.gim","oa.gim_up","oa.gim_up_31"]}
execute positioned ~44 ~34 ~-40 align xyz positioned ~0.5 ~0 ~0.5 run summon minecraft:block_display ~ ~ ~ {Tags:["oa.mdeco"],block_state:"minecraft:blue_wool",view_range:6.0f,Rotation:[0.0f,0.0f],transformation:{translation:[-2.500f,0.500f,-2.500f],left_rotation:[0.0f,0.0f,0.0f,1.0f],scale:[5.000f,5.000f,5.000f],right_rotation:[0.0f,0.0f,0.0f,1.0f]}}
execute positioned ~44 ~34 ~-40 align xyz positioned ~0.5 ~0 ~0.5 run summon minecraft:block_display ~ ~ ~ {Tags:["oa.mdeco"],block_state:"minecraft:yellow_wool",view_range:6.0f,Rotation:[20.0f,0.0f],transformation:{translation:[-3.000f,1.500f,-2.000f],left_rotation:[0.0f,0.0f,0.0f,1.0f],scale:[6.000f,3.000f,4.000f],right_rotation:[0.0f,0.0f,0.0f,1.0f]}}
execute positioned ~44 ~34 ~-40 align xyz positioned ~0.5 ~0 ~0.5 run summon minecraft:block_display ~ ~ ~ {Tags:["oa.mdeco"],block_state:"minecraft:yellow_wool",view_range:6.0f,Rotation:[20.0f,0.0f],transformation:{translation:[-2.000f,1.500f,-3.000f],left_rotation:[0.0f,0.0f,0.0f,1.0f],scale:[4.000f,3.000f,6.000f],right_rotation:[0.0f,0.0f,0.0f,1.0f]}}
execute positioned ~44 ~34 ~-40 align xyz positioned ~0.5 ~0 ~0.5 run summon minecraft:block_display ~ ~ ~ {Tags:["oa.mdeco"],block_state:"minecraft:blue_wool",view_range:6.0f,Rotation:[0.0f,0.0f],transformation:{translation:[-1.800f,5.500f,-1.800f],left_rotation:[0.0f,0.0f,0.0f,1.0f],scale:[3.600f,1.200f,3.600f],right_rotation:[0.0f,0.0f,0.0f,1.0f]}}
execute positioned ~44 ~34 ~-40 align xyz positioned ~0.5 ~0 ~0.5 run summon minecraft:block_display ~ ~ ~ {Tags:["oa.mdeco"],block_state:"minecraft:blue_wool",view_range:6.0f,Rotation:[0.0f,0.0f],transformation:{translation:[-1.500f,-0.600f,-1.500f],left_rotation:[0.0f,0.0f,0.0f,1.0f],scale:[3.000f,1.000f,3.000f],right_rotation:[0.0f,0.0f,0.0f,1.0f]}}
execute positioned ~44 ~34 ~-40 align xyz positioned ~0.5 ~0 ~0.5 run summon minecraft:block_display ~ ~ ~ {Tags:["oa.mdeco"],block_state:"minecraft:oak_fence",view_range:6.0f,Rotation:[0.0f,0.0f],transformation:{translation:[-0.960f,-3.200f,-0.960f],left_rotation:[0.0f,0.0f,0.0f,1.0f],scale:[0.120f,2.600f,0.120f],right_rotation:[0.0f,0.0f,0.0f,1.0f]}}
execute positioned ~44 ~34 ~-40 align xyz positioned ~0.5 ~0 ~0.5 run summon minecraft:block_display ~ ~ ~ {Tags:["oa.mdeco"],block_state:"minecraft:oak_fence",view_range:6.0f,Rotation:[0.0f,0.0f],transformation:{translation:[0.840f,-3.200f,-0.960f],left_rotation:[0.0f,0.0f,0.0f,1.0f],scale:[0.120f,2.600f,0.120f],right_rotation:[0.0f,0.0f,0.0f,1.0f]}}
execute positioned ~44 ~34 ~-40 align xyz positioned ~0.5 ~0 ~0.5 run summon minecraft:block_display ~ ~ ~ {Tags:["oa.mdeco"],block_state:"minecraft:oak_fence",view_range:6.0f,Rotation:[0.0f,0.0f],transformation:{translation:[-0.960f,-3.200f,0.840f],left_rotation:[0.0f,0.0f,0.0f,1.0f],scale:[0.120f,2.600f,0.120f],right_rotation:[0.0f,0.0f,0.0f,1.0f]}}
execute positioned ~44 ~34 ~-40 align xyz positioned ~0.5 ~0 ~0.5 run summon minecraft:block_display ~ ~ ~ {Tags:["oa.mdeco"],block_state:"minecraft:oak_fence",view_range:6.0f,Rotation:[0.0f,0.0f],transformation:{translation:[0.840f,-3.200f,0.840f],left_rotation:[0.0f,0.0f,0.0f,1.0f],scale:[0.120f,2.600f,0.120f],right_rotation:[0.0f,0.0f,0.0f,1.0f]}}
execute positioned ~44 ~34 ~-40 align xyz positioned ~0.5 ~0 ~0.5 run summon minecraft:block_display ~ ~ ~ {Tags:["oa.mdeco"],block_state:"minecraft:spruce_planks",view_range:6.0f,Rotation:[0.0f,0.0f],transformation:{translation:[-1.000f,-4.000f,-1.000f],left_rotation:[0.0f,0.0f,0.0f,1.0f],scale:[2.000f,1.000f,2.000f],right_rotation:[0.0f,0.0f,0.0f,1.0f]}}
execute unless score #localc oa.map2 = #expectedc oa.map2 run return run function oa:map/internal/job/failed
execute unless score #localo oa.map2 = #expectedo oa.map2 run return run function oa:map/internal/job/failed
scoreboard players operation #chests oa.map2 += #localc oa.map2
scoreboard players operation #ores oa.map2 += #localo oa.map2
function oa:maps/sky/tiles/release/36
scoreboard players add #tile oa.map2 1
execute store result storage oa_map2:args tile int 1 run scoreboard players get #tile oa.map2
execute if score #tile oa.map2 matches 100.. run return run function oa:map/internal/job/finish
schedule function oa:map/internal/job/next 1t replace
