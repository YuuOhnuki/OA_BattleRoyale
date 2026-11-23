execute if score #mode oa.map2 matches 0 run function oa:maps/end/tiles/place/36
execute if score #state oa.map2 matches 2 run return 0
execute positioned ~40 ~-40 ~-56 run kill @e[type=minecraft:marker,tag=br.chest,dx=31,dy=80,dz=31]
execute positioned ~40 ~-40 ~-56 run kill @e[type=minecraft:marker,tag=br.ore,dx=31,dy=80,dz=31]
execute positioned ~40 ~-40 ~-56 run kill @e[type=minecraft:marker,tag=oa.gim,dx=31,dy=80,dz=31]
execute positioned ~40 ~-40 ~-56 run kill @e[type=minecraft:block_display,tag=oa.mdeco,dx=31,dy=80,dz=31]
execute positioned ~40 ~-40 ~-56 run kill @e[type=minecraft:end_crystal,tag=oa.mdeco,dx=31,dy=80,dz=31]
scoreboard players set #stage oa.map2 2
scoreboard players set #localc oa.map2 0
scoreboard players set #localo oa.map2 0
scoreboard players set #expectedc oa.map2 0
scoreboard players set #expectedo oa.map2 0
execute if score #sv7 oa.map2 matches 0 run scoreboard players add #expectedc oa.map2 6
execute if score #sv7 oa.map2 matches 0 run scoreboard players add #expectedo oa.map2 5
execute if score #sv7 oa.map2 matches 0 positioned ~66 ~1 ~-51 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv7 oa.map2 matches 0 positioned ~52 ~1 ~-56 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv7 oa.map2 matches 0 positioned ~58 ~1 ~-37 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv7 oa.map2 matches 0 positioned ~46 ~1 ~-48 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv7 oa.map2 matches 0 positioned ~71 ~4 ~-50 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv7 oa.map2 matches 0 positioned ~55 ~1 ~-54 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv7 oa.map2 matches 0 positioned ~54 ~1 ~-55 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv7 oa.map2 matches 0 positioned ~56 ~1 ~-52 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv7 oa.map2 matches 0 positioned ~51 ~1 ~-49 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv7 oa.map2 matches 0 positioned ~52 ~1 ~-54 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv7 oa.map2 matches 0 positioned ~55 ~2 ~-38 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv7 oa.map2 matches 0 if score #mode oa.map2 matches 0 positioned ~55 ~1 ~-54 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv7 oa.map2 matches 0 if score #mode oa.map2 matches 0 positioned ~54 ~1 ~-55 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv7 oa.map2 matches 0 if score #mode oa.map2 matches 0 positioned ~56 ~1 ~-52 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv7 oa.map2 matches 0 if score #mode oa.map2 matches 0 positioned ~51 ~1 ~-49 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv7 oa.map2 matches 0 if score #mode oa.map2 matches 0 positioned ~52 ~1 ~-54 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv7 oa.map2 matches 0 if score #mode oa.map2 matches 0 positioned ~55 ~2 ~-38 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv7 oa.map2 matches 1 run scoreboard players add #expectedc oa.map2 6
execute if score #sv7 oa.map2 matches 1 run scoreboard players add #expectedo oa.map2 6
execute if score #sv7 oa.map2 matches 1 positioned ~70 ~1 ~-56 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv7 oa.map2 matches 1 positioned ~71 ~3 ~-52 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv7 oa.map2 matches 1 positioned ~66 ~1 ~-50 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv7 oa.map2 matches 1 positioned ~65 ~1 ~-50 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv7 oa.map2 matches 1 positioned ~66 ~1 ~-49 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv7 oa.map2 matches 1 positioned ~67 ~1 ~-49 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv7 oa.map2 matches 1 positioned ~53 ~1 ~-52 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv7 oa.map2 matches 1 positioned ~61 ~1 ~-52 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv7 oa.map2 matches 1 positioned ~47 ~1 ~-50 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv7 oa.map2 matches 1 positioned ~69 ~1 ~-56 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv7 oa.map2 matches 1 positioned ~52 ~1 ~-51 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv7 oa.map2 matches 1 positioned ~44 ~1 ~-52 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv7 oa.map2 matches 1 if score #mode oa.map2 matches 0 positioned ~53 ~1 ~-52 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv7 oa.map2 matches 1 if score #mode oa.map2 matches 0 positioned ~61 ~1 ~-52 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv7 oa.map2 matches 1 if score #mode oa.map2 matches 0 positioned ~47 ~1 ~-50 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv7 oa.map2 matches 1 if score #mode oa.map2 matches 0 positioned ~69 ~1 ~-56 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv7 oa.map2 matches 1 if score #mode oa.map2 matches 0 positioned ~52 ~1 ~-51 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv7 oa.map2 matches 1 if score #mode oa.map2 matches 0 positioned ~44 ~1 ~-52 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv7 oa.map2 matches 1 positioned ~52 ~7 ~-55 align xyz positioned ~0.5 ~0 ~0.5 run summon minecraft:block_display ~ ~ ~ {Tags:["oa.mdeco"],block_state:"minecraft:amethyst_block",view_range:6.0f,Rotation:[0.0f,0.0f],transformation:{translation:[-0.700f,0.000f,-0.700f],left_rotation:[0.2706f,0.0000f,0.2706f,0.9239f],scale:[1.400f,1.400f,1.400f],right_rotation:[0.0f,0.0f,0.0f,1.0f]},brightness:{block:15,sky:15}}
execute if score #sv7 oa.map2 matches 1 positioned ~52 ~7 ~-55 align xyz positioned ~0.5 ~0 ~0.5 run summon minecraft:block_display ~ ~ ~ {Tags:["oa.mdeco"],block_state:"minecraft:end_rod",view_range:6.0f,Rotation:[0.0f,0.0f],transformation:{translation:[-0.150f,-0.840f,-0.150f],left_rotation:[0.0000f,0.0000f,0.0000f,1.0000f],scale:[0.300f,3.080f,0.300f],right_rotation:[0.0f,0.0f,0.0f,1.0f]},brightness:{block:15,sky:15}}
execute if score #sv7 oa.map2 matches 1 positioned ~59 ~7 ~-48 align xyz positioned ~0.5 ~0 ~0.5 run summon minecraft:block_display ~ ~ ~ {Tags:["oa.mdeco"],block_state:"minecraft:amethyst_block",view_range:6.0f,Rotation:[0.0f,0.0f],transformation:{translation:[-0.700f,0.000f,-0.700f],left_rotation:[0.2706f,0.0000f,0.2706f,0.9239f],scale:[1.400f,1.400f,1.400f],right_rotation:[0.0f,0.0f,0.0f,1.0f]},brightness:{block:15,sky:15}}
execute if score #sv7 oa.map2 matches 1 positioned ~59 ~7 ~-48 align xyz positioned ~0.5 ~0 ~0.5 run summon minecraft:block_display ~ ~ ~ {Tags:["oa.mdeco"],block_state:"minecraft:end_rod",view_range:6.0f,Rotation:[0.0f,0.0f],transformation:{translation:[-0.150f,-0.840f,-0.150f],left_rotation:[0.0000f,0.0000f,0.0000f,1.0000f],scale:[0.300f,3.080f,0.300f],right_rotation:[0.0f,0.0f,0.0f,1.0f]},brightness:{block:15,sky:15}}
execute if score #sv7 oa.map2 matches 1 positioned ~63 ~7 ~-54 align xyz positioned ~0.5 ~0 ~0.5 run summon minecraft:block_display ~ ~ ~ {Tags:["oa.mdeco"],block_state:"minecraft:amethyst_block",view_range:6.0f,Rotation:[0.0f,0.0f],transformation:{translation:[-0.700f,0.000f,-0.700f],left_rotation:[0.2706f,0.0000f,0.2706f,0.9239f],scale:[1.400f,1.400f,1.400f],right_rotation:[0.0f,0.0f,0.0f,1.0f]},brightness:{block:15,sky:15}}
execute if score #sv7 oa.map2 matches 1 positioned ~63 ~7 ~-54 align xyz positioned ~0.5 ~0 ~0.5 run summon minecraft:block_display ~ ~ ~ {Tags:["oa.mdeco"],block_state:"minecraft:end_rod",view_range:6.0f,Rotation:[0.0f,0.0f],transformation:{translation:[-0.150f,-0.840f,-0.150f],left_rotation:[0.0000f,0.0000f,0.0000f,1.0000f],scale:[0.300f,3.080f,0.300f],right_rotation:[0.0f,0.0f,0.0f,1.0f]},brightness:{block:15,sky:15}}
execute if score #sv7 oa.map2 matches 2 run scoreboard players add #expectedc oa.map2 6
execute if score #sv7 oa.map2 matches 2 run scoreboard players add #expectedo oa.map2 4
execute if score #sv7 oa.map2 matches 2 positioned ~71 ~2 ~-43 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv7 oa.map2 matches 2 positioned ~46 ~1 ~-49 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv7 oa.map2 matches 2 positioned ~70 ~2 ~-43 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv7 oa.map2 matches 2 positioned ~71 ~2 ~-42 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv7 oa.map2 matches 2 positioned ~53 ~1 ~-52 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv7 oa.map2 matches 2 positioned ~61 ~1 ~-52 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv7 oa.map2 matches 2 positioned ~69 ~1 ~-56 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv7 oa.map2 matches 2 positioned ~71 ~3 ~-48 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv7 oa.map2 matches 2 positioned ~54 ~1 ~-55 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv7 oa.map2 matches 2 positioned ~60 ~1 ~-48 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv7 oa.map2 matches 2 if score #mode oa.map2 matches 0 positioned ~53 ~1 ~-52 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv7 oa.map2 matches 2 if score #mode oa.map2 matches 0 positioned ~61 ~1 ~-52 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv7 oa.map2 matches 2 if score #mode oa.map2 matches 0 positioned ~69 ~1 ~-56 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv7 oa.map2 matches 2 if score #mode oa.map2 matches 0 positioned ~71 ~3 ~-48 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv7 oa.map2 matches 2 if score #mode oa.map2 matches 0 positioned ~54 ~1 ~-55 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv7 oa.map2 matches 2 if score #mode oa.map2 matches 0 positioned ~60 ~1 ~-48 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute unless score #localc oa.map2 = #expectedc oa.map2 run return run function oa:map/internal/job/failed
execute unless score #localo oa.map2 = #expectedo oa.map2 run return run function oa:map/internal/job/failed
scoreboard players operation #chests oa.map2 += #localc oa.map2
scoreboard players operation #ores oa.map2 += #localo oa.map2
function oa:maps/end/tiles/release/36
scoreboard players add #tile oa.map2 1
execute store result storage oa_map2:args tile int 1 run scoreboard players get #tile oa.map2
execute if score #tile oa.map2 matches 100.. run return run function oa:map/internal/job/finish
schedule function oa:map/internal/job/next 1t replace
