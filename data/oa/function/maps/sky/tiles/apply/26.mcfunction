execute if score #mode oa.map2 matches 0 run function oa:maps/sky/tiles/place/26
execute if score #state oa.map2 matches 2 run return 0
execute positioned ~40 ~-40 ~-88 run kill @e[type=minecraft:marker,tag=br.chest,dx=31,dy=80,dz=31]
execute positioned ~40 ~-40 ~-88 run kill @e[type=minecraft:marker,tag=br.ore,dx=31,dy=80,dz=31]
execute positioned ~40 ~-40 ~-88 run kill @e[type=minecraft:marker,tag=oa.gim,dx=31,dy=80,dz=31]
execute positioned ~40 ~-40 ~-88 run kill @e[type=minecraft:block_display,tag=oa.mdeco,dx=31,dy=80,dz=31]
execute positioned ~40 ~-40 ~-88 run kill @e[type=minecraft:end_crystal,tag=oa.mdeco,dx=31,dy=80,dz=31]
scoreboard players set #stage oa.map2 2
scoreboard players set #localc oa.map2 0
scoreboard players set #localo oa.map2 0
scoreboard players set #expectedc oa.map2 0
scoreboard players set #expectedo oa.map2 0
execute positioned ~64 ~22 ~-64 align xyz positioned ~0.5 ~0 ~0.5 run summon minecraft:block_display ~ ~ ~ {Tags:["oa.mdeco"],block_state:"minecraft:dark_oak_planks",view_range:6.0f,Rotation:[210.0f,0.0f],transformation:{translation:[-1.500f,0.000f,-5.000f],left_rotation:[0.0000f,0.0000f,0.0000f,1.0000f],scale:[3.000f,1.600f,10.000f],right_rotation:[0.0f,0.0f,0.0f,1.0f]}}
execute positioned ~64 ~22 ~-64 align xyz positioned ~0.5 ~0 ~0.5 run summon minecraft:block_display ~ ~ ~ {Tags:["oa.mdeco"],block_state:"minecraft:dark_oak_planks",view_range:6.0f,Rotation:[210.0f,0.0f],transformation:{translation:[-1.000f,-0.600f,-6.000f],left_rotation:[0.0000f,0.0000f,0.0000f,1.0000f],scale:[2.000f,1.000f,12.000f],right_rotation:[0.0f,0.0f,0.0f,1.0f]}}
execute positioned ~64 ~22 ~-64 align xyz positioned ~0.5 ~0 ~0.5 run summon minecraft:block_display ~ ~ ~ {Tags:["oa.mdeco"],block_state:"minecraft:spruce_planks",view_range:6.0f,Rotation:[210.0f,0.0f],transformation:{translation:[-1.700f,1.600f,-5.200f],left_rotation:[0.0000f,0.0000f,0.0000f,1.0000f],scale:[3.400f,0.250f,10.400f],right_rotation:[0.0f,0.0f,0.0f,1.0f]}}
execute positioned ~64 ~22 ~-64 align xyz positioned ~0.5 ~0 ~0.5 run summon minecraft:block_display ~ ~ ~ {Tags:["oa.mdeco"],block_state:"minecraft:white_wool",view_range:6.0f,Rotation:[210.0f,0.0f],transformation:{translation:[-2.500f,4.800f,-6.500f],left_rotation:[0.0000f,0.0000f,0.0000f,1.0000f],scale:[5.000f,4.500f,13.000f],right_rotation:[0.0f,0.0f,0.0f,1.0f]}}
execute positioned ~64 ~22 ~-64 align xyz positioned ~0.5 ~0 ~0.5 run summon minecraft:block_display ~ ~ ~ {Tags:["oa.mdeco"],block_state:"minecraft:white_wool",view_range:6.0f,Rotation:[210.0f,0.0f],transformation:{translation:[-1.800f,5.500f,-7.500f],left_rotation:[0.0000f,0.0000f,0.0000f,1.0000f],scale:[3.600f,3.000f,15.000f],right_rotation:[0.0f,0.0f,0.0f,1.0f]}}
execute positioned ~64 ~22 ~-64 align xyz positioned ~0.5 ~0 ~0.5 run summon minecraft:block_display ~ ~ ~ {Tags:["oa.mdeco"],block_state:"minecraft:blue_wool",view_range:6.0f,Rotation:[210.0f,0.0f],transformation:{translation:[-2.600f,6.200f,-6.600f],left_rotation:[0.0000f,0.0000f,0.0000f,1.0000f],scale:[5.200f,0.800f,13.200f],right_rotation:[0.0f,0.0f,0.0f,1.0f]}}
execute positioned ~64 ~22 ~-64 align xyz positioned ~0.5 ~0 ~0.5 run summon minecraft:block_display ~ ~ ~ {Tags:["oa.mdeco"],block_state:"minecraft:blue_wool",view_range:6.0f,Rotation:[210.0f,0.0f],transformation:{translation:[-0.150f,4.600f,-8.200f],left_rotation:[0.0000f,0.0000f,0.0000f,1.0000f],scale:[0.300f,2.600f,2.400f],right_rotation:[0.0f,0.0f,0.0f,1.0f]}}
execute positioned ~64 ~22 ~-64 align xyz positioned ~0.5 ~0 ~0.5 run summon minecraft:block_display ~ ~ ~ {Tags:["oa.mdeco"],block_state:"minecraft:blue_wool",view_range:6.0f,Rotation:[210.0f,0.0f],transformation:{translation:[-1.700f,5.600f,-8.200f],left_rotation:[0.0000f,0.0000f,0.0000f,1.0000f],scale:[3.400f,0.300f,2.400f],right_rotation:[0.0f,0.0f,0.0f,1.0f]}}
execute positioned ~64 ~22 ~-64 align xyz positioned ~0.5 ~0 ~0.5 run summon minecraft:block_display ~ ~ ~ {Tags:["oa.mdeco"],block_state:"minecraft:gold_block",view_range:6.0f,Rotation:[210.0f,0.0f],transformation:{translation:[-0.300f,0.400f,-5.900f],left_rotation:[0.0000f,0.0000f,0.0000f,1.0000f],scale:[0.600f,0.600f,0.600f],right_rotation:[0.0f,0.0f,0.0f,1.0f]}}
execute positioned ~64 ~22 ~-64 align xyz positioned ~0.5 ~0 ~0.5 run summon minecraft:block_display ~ ~ ~ {Tags:["oa.mdeco"],block_state:"minecraft:oak_fence",view_range:6.0f,Rotation:[210.0f,0.0f],transformation:{translation:[-0.075f,1.800f,-3.075f],left_rotation:[0.0000f,0.0000f,0.0000f,1.0000f],scale:[0.150f,2.200f,0.150f],right_rotation:[0.0f,0.0f,0.0f,1.0f]}}
execute positioned ~64 ~22 ~-64 align xyz positioned ~0.5 ~0 ~0.5 run summon minecraft:block_display ~ ~ ~ {Tags:["oa.mdeco"],block_state:"minecraft:oak_fence",view_range:6.0f,Rotation:[210.0f,0.0f],transformation:{translation:[-0.075f,1.800f,2.925f],left_rotation:[0.0000f,0.0000f,0.0000f,1.0000f],scale:[0.150f,2.200f,0.150f],right_rotation:[0.0f,0.0f,0.0f,1.0f]}}
execute if score #sv7 oa.map2 matches 0 run scoreboard players add #expectedc oa.map2 5
execute if score #sv7 oa.map2 matches 0 run scoreboard players add #expectedo oa.map2 3
execute if score #sv7 oa.map2 matches 0 positioned ~57 ~1 ~-64 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv7 oa.map2 matches 0 positioned ~70 ~1 ~-68 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv7 oa.map2 matches 0 positioned ~64 ~1 ~-61 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv7 oa.map2 matches 0 positioned ~60 ~1 ~-74 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv7 oa.map2 matches 0 positioned ~68 ~1 ~-74 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv7 oa.map2 matches 0 positioned ~71 ~1 ~-63 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv7 oa.map2 matches 0 positioned ~56 ~1 ~-72 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv7 oa.map2 matches 0 positioned ~63 ~1 ~-67 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv7 oa.map2 matches 0 if score #mode oa.map2 matches 0 positioned ~60 ~1 ~-74 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv7 oa.map2 matches 0 if score #mode oa.map2 matches 0 positioned ~68 ~1 ~-74 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv7 oa.map2 matches 0 if score #mode oa.map2 matches 0 positioned ~71 ~1 ~-63 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv7 oa.map2 matches 0 if score #mode oa.map2 matches 0 positioned ~56 ~1 ~-72 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv7 oa.map2 matches 0 if score #mode oa.map2 matches 0 positioned ~63 ~1 ~-67 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv7 oa.map2 matches 1 run scoreboard players add #expectedc oa.map2 5
execute if score #sv7 oa.map2 matches 1 run scoreboard players add #expectedo oa.map2 4
execute if score #sv7 oa.map2 matches 1 positioned ~58 ~1 ~-64 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv7 oa.map2 matches 1 positioned ~57 ~1 ~-68 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv7 oa.map2 matches 1 positioned ~68 ~1 ~-63 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv7 oa.map2 matches 1 positioned ~60 ~1 ~-58 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv7 oa.map2 matches 1 positioned ~62 ~1 ~-72 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv7 oa.map2 matches 1 positioned ~65 ~1 ~-72 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv7 oa.map2 matches 1 positioned ~59 ~1 ~-80 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv7 oa.map2 matches 1 positioned ~71 ~1 ~-73 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv7 oa.map2 matches 1 positioned ~57 ~1 ~-66 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv7 oa.map2 matches 1 if score #mode oa.map2 matches 0 positioned ~62 ~1 ~-72 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv7 oa.map2 matches 1 if score #mode oa.map2 matches 0 positioned ~65 ~1 ~-72 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv7 oa.map2 matches 1 if score #mode oa.map2 matches 0 positioned ~59 ~1 ~-80 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv7 oa.map2 matches 1 if score #mode oa.map2 matches 0 positioned ~71 ~1 ~-73 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv7 oa.map2 matches 1 if score #mode oa.map2 matches 0 positioned ~57 ~1 ~-66 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv7 oa.map2 matches 2 run scoreboard players add #expectedc oa.map2 7
execute if score #sv7 oa.map2 matches 2 run scoreboard players add #expectedo oa.map2 3
execute if score #sv7 oa.map2 matches 2 positioned ~55 ~1 ~-82 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv7 oa.map2 matches 2 positioned ~61 ~1 ~-75 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv7 oa.map2 matches 2 positioned ~60 ~1 ~-81 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv7 oa.map2 matches 2 positioned ~58 ~1 ~-74 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv7 oa.map2 matches 2 positioned ~70 ~1 ~-74 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv7 oa.map2 matches 2 positioned ~58 ~1 ~-66 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv7 oa.map2 matches 2 positioned ~70 ~1 ~-66 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv7 oa.map2 matches 2 positioned ~67 ~1 ~-63 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv7 oa.map2 matches 2 positioned ~70 ~1 ~-71 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv7 oa.map2 matches 2 positioned ~61 ~1 ~-68 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv7 oa.map2 matches 2 if score #mode oa.map2 matches 0 positioned ~58 ~1 ~-74 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv7 oa.map2 matches 2 if score #mode oa.map2 matches 0 positioned ~70 ~1 ~-74 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv7 oa.map2 matches 2 if score #mode oa.map2 matches 0 positioned ~58 ~1 ~-66 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv7 oa.map2 matches 2 if score #mode oa.map2 matches 0 positioned ~70 ~1 ~-66 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv7 oa.map2 matches 2 if score #mode oa.map2 matches 0 positioned ~67 ~1 ~-63 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv7 oa.map2 matches 2 if score #mode oa.map2 matches 0 positioned ~70 ~1 ~-71 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv7 oa.map2 matches 2 if score #mode oa.map2 matches 0 positioned ~61 ~1 ~-68 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute unless score #localc oa.map2 = #expectedc oa.map2 run return run function oa:map/internal/job/failed
execute unless score #localo oa.map2 = #expectedo oa.map2 run return run function oa:map/internal/job/failed
scoreboard players operation #chests oa.map2 += #localc oa.map2
scoreboard players operation #ores oa.map2 += #localo oa.map2
function oa:maps/sky/tiles/release/26
scoreboard players add #tile oa.map2 1
execute store result storage oa_map2:args tile int 1 run scoreboard players get #tile oa.map2
execute if score #tile oa.map2 matches 100.. run return run function oa:map/internal/job/finish
schedule function oa:map/internal/job/next 1t replace
