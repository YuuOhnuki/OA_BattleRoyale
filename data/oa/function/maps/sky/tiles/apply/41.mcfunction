execute if score #mode oa.map2 matches 0 run function oa:maps/sky/tiles/place/41
execute if score #state oa.map2 matches 2 run return 0
execute positioned ~-120 ~-40 ~-24 run kill @e[type=minecraft:marker,tag=br.chest,dx=31,dy=80,dz=31]
execute positioned ~-120 ~-40 ~-24 run kill @e[type=minecraft:marker,tag=br.ore,dx=31,dy=80,dz=31]
execute positioned ~-120 ~-40 ~-24 run kill @e[type=minecraft:marker,tag=oa.gim,dx=31,dy=80,dz=31]
execute positioned ~-120 ~-40 ~-24 run kill @e[type=minecraft:block_display,tag=oa.mdeco,dx=31,dy=80,dz=31]
execute positioned ~-120 ~-40 ~-24 run kill @e[type=minecraft:end_crystal,tag=oa.mdeco,dx=31,dy=80,dz=31]
scoreboard players set #stage oa.map2 2
scoreboard players set #localc oa.map2 0
scoreboard players set #localo oa.map2 0
scoreboard players set #expectedc oa.map2 0
scoreboard players set #expectedo oa.map2 0
execute if score #sv4 oa.map2 matches 0 run scoreboard players add #expectedc oa.map2 6
execute if score #sv4 oa.map2 matches 0 run scoreboard players add #expectedo oa.map2 4
execute if score #sv4 oa.map2 matches 0 positioned ~-100 ~1 ~-3 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv4 oa.map2 matches 0 positioned ~-92 ~1 ~1 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv4 oa.map2 matches 0 positioned ~-102 ~1 ~-4 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv4 oa.map2 matches 0 positioned ~-97 ~1 ~-13 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv4 oa.map2 matches 0 positioned ~-93 ~1 ~-8 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest_rich
execute if score #sv4 oa.map2 matches 0 positioned ~-92 ~1 ~-3 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv4 oa.map2 matches 0 positioned ~-94 ~1 ~-23 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv4 oa.map2 matches 0 positioned ~-107 ~7 ~-14 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv4 oa.map2 matches 0 positioned ~-90 ~1 ~-14 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv4 oa.map2 matches 0 positioned ~-89 ~1 ~-9 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv4 oa.map2 matches 0 if score #mode oa.map2 matches 0 positioned ~-93 ~1 ~-8 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_site
execute if score #sv4 oa.map2 matches 0 if score #mode oa.map2 matches 0 positioned ~-92 ~1 ~-3 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv4 oa.map2 matches 0 if score #mode oa.map2 matches 0 positioned ~-94 ~1 ~-23 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv4 oa.map2 matches 0 if score #mode oa.map2 matches 0 positioned ~-107 ~7 ~-14 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv4 oa.map2 matches 0 if score #mode oa.map2 matches 0 positioned ~-90 ~1 ~-14 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv4 oa.map2 matches 0 if score #mode oa.map2 matches 0 positioned ~-89 ~1 ~-9 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv4 oa.map2 matches 1 run scoreboard players add #expectedc oa.map2 5
execute if score #sv4 oa.map2 matches 1 run scoreboard players add #expectedo oa.map2 4
execute if score #sv4 oa.map2 matches 1 positioned ~-103 ~4 ~-18 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv4 oa.map2 matches 1 positioned ~-89 ~1 ~-3 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv4 oa.map2 matches 1 positioned ~-93 ~1 ~3 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv4 oa.map2 matches 1 positioned ~-102 ~1 ~0 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv4 oa.map2 matches 1 positioned ~-120 ~1 ~-12 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv4 oa.map2 matches 1 positioned ~-114 ~1 ~-12 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv4 oa.map2 matches 1 positioned ~-95 ~1 ~-10 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv4 oa.map2 matches 1 positioned ~-92 ~1 ~-10 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv4 oa.map2 matches 1 positioned ~-106 ~4 ~-13 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv4 oa.map2 matches 1 if score #mode oa.map2 matches 0 positioned ~-120 ~1 ~-12 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv4 oa.map2 matches 1 if score #mode oa.map2 matches 0 positioned ~-114 ~1 ~-12 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv4 oa.map2 matches 1 if score #mode oa.map2 matches 0 positioned ~-95 ~1 ~-10 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv4 oa.map2 matches 1 if score #mode oa.map2 matches 0 positioned ~-92 ~1 ~-10 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv4 oa.map2 matches 1 if score #mode oa.map2 matches 0 positioned ~-106 ~4 ~-13 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv4 oa.map2 matches 1 positioned ~-117 ~7 ~-12 align xyz positioned ~0.5 ~0 ~0.5 run summon minecraft:block_display ~ ~ ~ {Tags:["oa.mdeco"],block_state:"minecraft:white_wool",view_range:6.0f,Rotation:[-90.0f,0.0f],transformation:{translation:[-2.500f,0.000f,-6.500f],left_rotation:[0.0000f,0.0000f,0.0000f,1.0000f],scale:[5.000f,4.500f,13.000f],right_rotation:[0.0f,0.0f,0.0f,1.0f]}}
execute if score #sv4 oa.map2 matches 1 positioned ~-117 ~7 ~-12 align xyz positioned ~0.5 ~0 ~0.5 run summon minecraft:block_display ~ ~ ~ {Tags:["oa.mdeco"],block_state:"minecraft:red_wool",view_range:6.0f,Rotation:[-90.0f,0.0f],transformation:{translation:[-2.600f,1.400f,-6.600f],left_rotation:[0.0000f,0.0000f,0.0000f,1.0000f],scale:[5.200f,0.800f,13.200f],right_rotation:[0.0f,0.0f,0.0f,1.0f]}}
execute if score #sv4 oa.map2 matches 2 run scoreboard players add #expectedc oa.map2 6
execute if score #sv4 oa.map2 matches 2 run scoreboard players add #expectedo oa.map2 3
execute if score #sv4 oa.map2 matches 2 positioned ~-102 ~1 ~-8 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv4 oa.map2 matches 2 positioned ~-90 ~1 ~-16 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv4 oa.map2 matches 2 positioned ~-97 ~1 ~0 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv4 oa.map2 matches 2 positioned ~-97 ~1 ~-12 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv4 oa.map2 matches 2 positioned ~-89 ~1 ~-12 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv4 oa.map2 matches 2 positioned ~-95 ~1 ~3 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv4 oa.map2 matches 2 positioned ~-102 ~5 ~-20 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv4 oa.map2 matches 2 positioned ~-95 ~1 ~-2 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv4 oa.map2 matches 2 positioned ~-106 ~3 ~-10 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv4 oa.map2 matches 2 if score #mode oa.map2 matches 0 positioned ~-97 ~1 ~-12 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv4 oa.map2 matches 2 if score #mode oa.map2 matches 0 positioned ~-89 ~1 ~-12 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv4 oa.map2 matches 2 if score #mode oa.map2 matches 0 positioned ~-95 ~1 ~3 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv4 oa.map2 matches 2 if score #mode oa.map2 matches 0 positioned ~-102 ~5 ~-20 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv4 oa.map2 matches 2 if score #mode oa.map2 matches 0 positioned ~-95 ~1 ~-2 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv4 oa.map2 matches 2 if score #mode oa.map2 matches 0 positioned ~-106 ~3 ~-10 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute unless score #localc oa.map2 = #expectedc oa.map2 run return run function oa:map/internal/job/failed
execute unless score #localo oa.map2 = #expectedo oa.map2 run return run function oa:map/internal/job/failed
scoreboard players operation #chests oa.map2 += #localc oa.map2
scoreboard players operation #ores oa.map2 += #localo oa.map2
function oa:maps/sky/tiles/release/41
scoreboard players add #tile oa.map2 1
execute store result storage oa_map2:args tile int 1 run scoreboard players get #tile oa.map2
execute if score #tile oa.map2 matches 100.. run return run function oa:map/internal/job/finish
schedule function oa:map/internal/job/next 1t replace
