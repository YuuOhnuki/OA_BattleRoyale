execute if score #mode oa.map2 matches 0 run function oa:maps/sky/tiles/place/76
execute if score #state oa.map2 matches 2 run return 0
execute positioned ~40 ~-40 ~72 run kill @e[type=minecraft:marker,tag=br.chest,dx=31,dy=80,dz=31]
execute positioned ~40 ~-40 ~72 run kill @e[type=minecraft:marker,tag=br.ore,dx=31,dy=80,dz=31]
execute positioned ~40 ~-40 ~72 run kill @e[type=minecraft:marker,tag=oa.gim,dx=31,dy=80,dz=31]
execute positioned ~40 ~-40 ~72 run kill @e[type=minecraft:block_display,tag=oa.mdeco,dx=31,dy=80,dz=31]
execute positioned ~40 ~-40 ~72 run kill @e[type=minecraft:end_crystal,tag=oa.mdeco,dx=31,dy=80,dz=31]
scoreboard players set #stage oa.map2 2
scoreboard players set #localc oa.map2 0
scoreboard players set #localo oa.map2 0
scoreboard players set #expectedc oa.map2 0
scoreboard players set #expectedo oa.map2 0
execute if score #sv1 oa.map2 matches 0 run scoreboard players add #expectedc oa.map2 1
execute if score #sv1 oa.map2 matches 0 run scoreboard players add #expectedo oa.map2 1
execute if score #sv1 oa.map2 matches 0 positioned ~60 ~1 ~80 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv1 oa.map2 matches 0 positioned ~66 ~6 ~89 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv1 oa.map2 matches 0 if score #mode oa.map2 matches 0 positioned ~66 ~6 ~89 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv1 oa.map2 matches 1 run scoreboard players add #expectedc oa.map2 3
execute if score #sv1 oa.map2 matches 1 run scoreboard players add #expectedo oa.map2 2
execute if score #sv1 oa.map2 matches 1 positioned ~68 ~1 ~78 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv1 oa.map2 matches 1 positioned ~71 ~1 ~81 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv1 oa.map2 matches 1 positioned ~59 ~1 ~97 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv1 oa.map2 matches 1 positioned ~60 ~1 ~91 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv1 oa.map2 matches 1 positioned ~69 ~1 ~75 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv1 oa.map2 matches 1 if score #mode oa.map2 matches 0 positioned ~59 ~1 ~97 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv1 oa.map2 matches 1 if score #mode oa.map2 matches 0 positioned ~60 ~1 ~91 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv1 oa.map2 matches 1 if score #mode oa.map2 matches 0 positioned ~69 ~1 ~75 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv1 oa.map2 matches 1 positioned ~59 ~7 ~94 align xyz positioned ~0.5 ~0 ~0.5 run summon minecraft:block_display ~ ~ ~ {Tags:["oa.mdeco"],block_state:"minecraft:white_wool",view_range:6.0f,Rotation:[-10.0f,0.0f],transformation:{translation:[-2.500f,0.000f,-6.500f],left_rotation:[0.0000f,0.0000f,0.0000f,1.0000f],scale:[5.000f,4.500f,13.000f],right_rotation:[0.0f,0.0f,0.0f,1.0f]}}
execute if score #sv1 oa.map2 matches 1 positioned ~59 ~7 ~94 align xyz positioned ~0.5 ~0 ~0.5 run summon minecraft:block_display ~ ~ ~ {Tags:["oa.mdeco"],block_state:"minecraft:red_wool",view_range:6.0f,Rotation:[-10.0f,0.0f],transformation:{translation:[-2.600f,1.400f,-6.600f],left_rotation:[0.0000f,0.0000f,0.0000f,1.0000f],scale:[5.200f,0.800f,13.200f],right_rotation:[0.0f,0.0f,0.0f,1.0f]}}
execute if score #sv1 oa.map2 matches 2 run scoreboard players add #expectedc oa.map2 2
execute if score #sv1 oa.map2 matches 2 run scoreboard players add #expectedo oa.map2 3
execute if score #sv1 oa.map2 matches 2 positioned ~62 ~1 ~80 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv1 oa.map2 matches 2 positioned ~61 ~3 ~84 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv1 oa.map2 matches 2 positioned ~66 ~1 ~79 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv1 oa.map2 matches 2 positioned ~65 ~1 ~77 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv1 oa.map2 matches 2 positioned ~59 ~1 ~75 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv1 oa.map2 matches 2 if score #mode oa.map2 matches 0 positioned ~65 ~1 ~77 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv1 oa.map2 matches 2 if score #mode oa.map2 matches 0 positioned ~59 ~1 ~75 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute unless score #localc oa.map2 = #expectedc oa.map2 run return run function oa:map/internal/job/failed
execute unless score #localo oa.map2 = #expectedo oa.map2 run return run function oa:map/internal/job/failed
scoreboard players operation #chests oa.map2 += #localc oa.map2
scoreboard players operation #ores oa.map2 += #localo oa.map2
function oa:maps/sky/tiles/release/76
scoreboard players add #tile oa.map2 1
execute store result storage oa_map2:args tile int 1 run scoreboard players get #tile oa.map2
execute if score #tile oa.map2 matches 100.. run return run function oa:map/internal/job/finish
schedule function oa:map/internal/job/next 1t replace
