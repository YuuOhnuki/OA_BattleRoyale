execute if score #mode oa.map2 matches 0 run function oa:maps/end/tiles/place/14
execute if score #state oa.map2 matches 2 run return 0
execute positioned ~-24 ~-40 ~-120 run kill @e[type=minecraft:marker,tag=br.chest,dx=31,dy=80,dz=31]
execute positioned ~-24 ~-40 ~-120 run kill @e[type=minecraft:marker,tag=br.ore,dx=31,dy=80,dz=31]
execute positioned ~-24 ~-40 ~-120 run kill @e[type=minecraft:marker,tag=oa.gim,dx=31,dy=80,dz=31]
scoreboard players set #stage oa.map2 2
scoreboard players set #localc oa.map2 0
scoreboard players set #localo oa.map2 0
scoreboard players set #expectedc oa.map2 0
scoreboard players set #expectedo oa.map2 0
execute if score #sv6 oa.map2 matches 0 run scoreboard players add #expectedc oa.map2 5
execute if score #sv6 oa.map2 matches 0 positioned ~0 ~1 ~-95 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv6 oa.map2 matches 0 positioned ~3 ~1 ~-95 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv6 oa.map2 matches 0 positioned ~-3 ~1 ~-105 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv6 oa.map2 matches 0 positioned ~-9 ~1 ~-96 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv6 oa.map2 matches 0 positioned ~0 ~1 ~-97 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv6 oa.map2 matches 0 if score #mode oa.map2 matches 0 positioned ~0 ~1 ~-95 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv6 oa.map2 matches 0 if score #mode oa.map2 matches 0 positioned ~3 ~1 ~-95 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv6 oa.map2 matches 0 if score #mode oa.map2 matches 0 positioned ~-3 ~1 ~-105 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv6 oa.map2 matches 0 if score #mode oa.map2 matches 0 positioned ~-9 ~1 ~-96 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv6 oa.map2 matches 0 if score #mode oa.map2 matches 0 positioned ~0 ~1 ~-97 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv6 oa.map2 matches 1 run scoreboard players add #expectedc oa.map2 5
execute if score #sv6 oa.map2 matches 1 run scoreboard players add #expectedo oa.map2 3
execute if score #sv6 oa.map2 matches 1 positioned ~3 ~1 ~-99 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv6 oa.map2 matches 1 positioned ~-4 ~1 ~-91 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv6 oa.map2 matches 1 positioned ~4 ~1 ~-104 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv6 oa.map2 matches 1 positioned ~1 ~1 ~-94 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv6 oa.map2 matches 1 positioned ~3 ~1 ~-94 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv6 oa.map2 matches 1 positioned ~-2 ~1 ~-94 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv6 oa.map2 matches 1 positioned ~-13 ~1 ~-94 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv6 oa.map2 matches 1 positioned ~6 ~1 ~-108 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv6 oa.map2 matches 1 if score #mode oa.map2 matches 0 positioned ~1 ~1 ~-94 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv6 oa.map2 matches 1 if score #mode oa.map2 matches 0 positioned ~3 ~1 ~-94 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv6 oa.map2 matches 1 if score #mode oa.map2 matches 0 positioned ~-2 ~1 ~-94 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv6 oa.map2 matches 1 if score #mode oa.map2 matches 0 positioned ~-13 ~1 ~-94 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv6 oa.map2 matches 1 if score #mode oa.map2 matches 0 positioned ~6 ~1 ~-108 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv6 oa.map2 matches 2 run scoreboard players add #expectedc oa.map2 5
execute if score #sv6 oa.map2 matches 2 run scoreboard players add #expectedo oa.map2 2
execute if score #sv6 oa.map2 matches 2 positioned ~-2 ~1 ~-97 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv6 oa.map2 matches 2 positioned ~3 ~1 ~-103 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv6 oa.map2 matches 2 positioned ~3 ~15 ~-92 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv6 oa.map2 matches 2 positioned ~3 ~1 ~-92 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv6 oa.map2 matches 2 positioned ~-10 ~1 ~-102 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv6 oa.map2 matches 2 positioned ~-4 ~1 ~-95 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv6 oa.map2 matches 2 positioned ~-3 ~1 ~-103 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv6 oa.map2 matches 2 if score #mode oa.map2 matches 0 positioned ~3 ~15 ~-92 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv6 oa.map2 matches 2 if score #mode oa.map2 matches 0 positioned ~3 ~1 ~-92 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv6 oa.map2 matches 2 if score #mode oa.map2 matches 0 positioned ~-10 ~1 ~-102 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv6 oa.map2 matches 2 if score #mode oa.map2 matches 0 positioned ~-4 ~1 ~-95 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv6 oa.map2 matches 2 if score #mode oa.map2 matches 0 positioned ~-3 ~1 ~-103 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute unless score #localc oa.map2 = #expectedc oa.map2 run return run function oa:map/internal/job/failed
execute unless score #localo oa.map2 = #expectedo oa.map2 run return run function oa:map/internal/job/failed
scoreboard players operation #chests oa.map2 += #localc oa.map2
scoreboard players operation #ores oa.map2 += #localo oa.map2
function oa:maps/end/tiles/release/14
scoreboard players add #tile oa.map2 1
execute store result storage oa_map2:args tile int 1 run scoreboard players get #tile oa.map2
execute if score #tile oa.map2 matches 100.. run return run function oa:map/internal/job/finish
schedule function oa:map/internal/job/next 1t replace
