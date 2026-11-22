execute if score #mode oa.map2 matches 0 run function oa:maps/sky/tiles/place/72
execute if score #state oa.map2 matches 2 run return 0
execute positioned ~-88 ~-40 ~72 run kill @e[type=minecraft:marker,tag=br.chest,dx=31,dy=80,dz=31]
execute positioned ~-88 ~-40 ~72 run kill @e[type=minecraft:marker,tag=br.ore,dx=31,dy=80,dz=31]
execute positioned ~-88 ~-40 ~72 run kill @e[type=minecraft:marker,tag=oa.gim,dx=31,dy=80,dz=31]
execute positioned ~-88 ~-40 ~72 run kill @e[type=minecraft:block_display,tag=oa.mdeco,dx=31,dy=80,dz=31]
execute positioned ~-88 ~-40 ~72 run kill @e[type=minecraft:end_crystal,tag=oa.mdeco,dx=31,dy=80,dz=31]
scoreboard players set #stage oa.map2 2
scoreboard players set #localc oa.map2 0
scoreboard players set #localo oa.map2 0
scoreboard players set #expectedc oa.map2 0
scoreboard players set #expectedo oa.map2 0
execute if score #sv3 oa.map2 matches 0 run scoreboard players add #expectedc oa.map2 3
execute if score #sv3 oa.map2 matches 0 run scoreboard players add #expectedo oa.map2 2
execute if score #sv3 oa.map2 matches 0 positioned ~-71 ~1 ~85 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv3 oa.map2 matches 0 positioned ~-83 ~1 ~75 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv3 oa.map2 matches 0 positioned ~-76 ~1 ~76 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv3 oa.map2 matches 0 positioned ~-78 ~1 ~77 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv3 oa.map2 matches 0 positioned ~-76 ~1 ~83 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv3 oa.map2 matches 0 if score #mode oa.map2 matches 0 positioned ~-76 ~1 ~76 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv3 oa.map2 matches 0 if score #mode oa.map2 matches 0 positioned ~-78 ~1 ~77 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv3 oa.map2 matches 0 if score #mode oa.map2 matches 0 positioned ~-76 ~1 ~83 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv3 oa.map2 matches 1 run scoreboard players add #expectedc oa.map2 5
execute if score #sv3 oa.map2 matches 1 run scoreboard players add #expectedo oa.map2 2
execute if score #sv3 oa.map2 matches 1 positioned ~-64 ~1 ~74 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv3 oa.map2 matches 1 positioned ~-64 ~2 ~82 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv3 oa.map2 matches 1 positioned ~-78 ~5 ~74 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv3 oa.map2 matches 1 positioned ~-70 ~5 ~74 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv3 oa.map2 matches 1 positioned ~-79 ~1 ~73 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv3 oa.map2 matches 1 positioned ~-85 ~1 ~73 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv3 oa.map2 matches 1 positioned ~-71 ~1 ~80 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv3 oa.map2 matches 1 if score #mode oa.map2 matches 0 positioned ~-78 ~5 ~74 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv3 oa.map2 matches 1 if score #mode oa.map2 matches 0 positioned ~-70 ~5 ~74 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv3 oa.map2 matches 1 if score #mode oa.map2 matches 0 positioned ~-79 ~1 ~73 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv3 oa.map2 matches 1 if score #mode oa.map2 matches 0 positioned ~-85 ~1 ~73 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv3 oa.map2 matches 1 if score #mode oa.map2 matches 0 positioned ~-71 ~1 ~80 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv3 oa.map2 matches 2 run scoreboard players add #expectedc oa.map2 1
execute if score #sv3 oa.map2 matches 2 run scoreboard players add #expectedo oa.map2 1
execute if score #sv3 oa.map2 matches 2 positioned ~-71 ~1 ~85 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv3 oa.map2 matches 2 positioned ~-65 ~3 ~84 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv3 oa.map2 matches 2 if score #mode oa.map2 matches 0 positioned ~-65 ~3 ~84 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute unless score #localc oa.map2 = #expectedc oa.map2 run return run function oa:map/internal/job/failed
execute unless score #localo oa.map2 = #expectedo oa.map2 run return run function oa:map/internal/job/failed
scoreboard players operation #chests oa.map2 += #localc oa.map2
scoreboard players operation #ores oa.map2 += #localo oa.map2
function oa:maps/sky/tiles/release/72
scoreboard players add #tile oa.map2 1
execute store result storage oa_map2:args tile int 1 run scoreboard players get #tile oa.map2
execute if score #tile oa.map2 matches 100.. run return run function oa:map/internal/job/finish
schedule function oa:map/internal/job/next 1t replace
