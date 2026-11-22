execute if score #mode oa.map2 matches 0 run function oa:maps/end/tiles/place/72
execute if score #state oa.map2 matches 2 run return 0
execute positioned ~-88 ~-40 ~72 run kill @e[type=minecraft:marker,tag=br.chest,dx=31,dy=80,dz=31]
execute positioned ~-88 ~-40 ~72 run kill @e[type=minecraft:marker,tag=br.ore,dx=31,dy=80,dz=31]
execute positioned ~-88 ~-40 ~72 run kill @e[type=minecraft:marker,tag=oa.gim,dx=31,dy=80,dz=31]
execute positioned ~-88 ~-40 ~72 run kill @e[type=minecraft:block_display,tag=oa.mdeco,dx=31,dy=80,dz=31]
scoreboard players set #stage oa.map2 2
scoreboard players set #localc oa.map2 0
scoreboard players set #localo oa.map2 0
scoreboard players set #expectedc oa.map2 0
scoreboard players set #expectedo oa.map2 0
execute if score #sv3 oa.map2 matches 0 run scoreboard players add #expectedc oa.map2 6
execute if score #sv3 oa.map2 matches 0 run scoreboard players add #expectedo oa.map2 3
execute if score #sv3 oa.map2 matches 0 positioned ~-77 ~1 ~82 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv3 oa.map2 matches 0 positioned ~-70 ~1 ~90 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv3 oa.map2 matches 0 positioned ~-61 ~1 ~86 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv3 oa.map2 matches 0 positioned ~-67 ~1 ~77 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv3 oa.map2 matches 0 positioned ~-65 ~1 ~77 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv3 oa.map2 matches 0 positioned ~-72 ~2 ~93 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv3 oa.map2 matches 0 positioned ~-70 ~1 ~83 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv3 oa.map2 matches 0 positioned ~-64 ~3 ~92 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv3 oa.map2 matches 0 positioned ~-79 ~1 ~80 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv3 oa.map2 matches 0 if score #mode oa.map2 matches 0 positioned ~-67 ~1 ~77 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv3 oa.map2 matches 0 if score #mode oa.map2 matches 0 positioned ~-65 ~1 ~77 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv3 oa.map2 matches 0 if score #mode oa.map2 matches 0 positioned ~-72 ~2 ~93 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv3 oa.map2 matches 0 if score #mode oa.map2 matches 0 positioned ~-70 ~1 ~83 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv3 oa.map2 matches 0 if score #mode oa.map2 matches 0 positioned ~-64 ~3 ~92 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv3 oa.map2 matches 0 if score #mode oa.map2 matches 0 positioned ~-79 ~1 ~80 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv3 oa.map2 matches 1 run scoreboard players add #expectedc oa.map2 5
execute if score #sv3 oa.map2 matches 1 run scoreboard players add #expectedo oa.map2 4
execute if score #sv3 oa.map2 matches 1 positioned ~-74 ~1 ~77 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv3 oa.map2 matches 1 positioned ~-58 ~1 ~85 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv3 oa.map2 matches 1 positioned ~-69 ~1 ~73 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv3 oa.map2 matches 1 positioned ~-62 ~1 ~86 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv3 oa.map2 matches 1 positioned ~-68 ~1 ~76 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv3 oa.map2 matches 1 positioned ~-68 ~5 ~76 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv3 oa.map2 matches 1 positioned ~-79 ~2 ~77 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv3 oa.map2 matches 1 positioned ~-61 ~1 ~86 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv3 oa.map2 matches 1 positioned ~-68 ~1 ~79 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv3 oa.map2 matches 1 if score #mode oa.map2 matches 0 positioned ~-68 ~1 ~76 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv3 oa.map2 matches 1 if score #mode oa.map2 matches 0 positioned ~-68 ~5 ~76 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv3 oa.map2 matches 1 if score #mode oa.map2 matches 0 positioned ~-79 ~2 ~77 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv3 oa.map2 matches 1 if score #mode oa.map2 matches 0 positioned ~-61 ~1 ~86 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv3 oa.map2 matches 1 if score #mode oa.map2 matches 0 positioned ~-68 ~1 ~79 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv3 oa.map2 matches 2 run scoreboard players add #expectedc oa.map2 6
execute if score #sv3 oa.map2 matches 2 run scoreboard players add #expectedo oa.map2 5
execute if score #sv3 oa.map2 matches 2 positioned ~-80 ~1 ~82 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv3 oa.map2 matches 2 positioned ~-61 ~1 ~74 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv3 oa.map2 matches 2 positioned ~-72 ~1 ~90 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv3 oa.map2 matches 2 positioned ~-60 ~1 ~84 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv3 oa.map2 matches 2 positioned ~-62 ~1 ~83 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv3 oa.map2 matches 2 positioned ~-67 ~1 ~77 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv3 oa.map2 matches 2 positioned ~-65 ~1 ~77 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv3 oa.map2 matches 2 positioned ~-71 ~1 ~78 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv3 oa.map2 matches 2 positioned ~-63 ~1 ~85 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv3 oa.map2 matches 2 positioned ~-65 ~1 ~87 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv3 oa.map2 matches 2 positioned ~-70 ~1 ~80 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv3 oa.map2 matches 2 if score #mode oa.map2 matches 0 positioned ~-67 ~1 ~77 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv3 oa.map2 matches 2 if score #mode oa.map2 matches 0 positioned ~-65 ~1 ~77 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv3 oa.map2 matches 2 if score #mode oa.map2 matches 0 positioned ~-71 ~1 ~78 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv3 oa.map2 matches 2 if score #mode oa.map2 matches 0 positioned ~-63 ~1 ~85 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv3 oa.map2 matches 2 if score #mode oa.map2 matches 0 positioned ~-65 ~1 ~87 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv3 oa.map2 matches 2 if score #mode oa.map2 matches 0 positioned ~-70 ~1 ~80 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute unless score #localc oa.map2 = #expectedc oa.map2 run return run function oa:map/internal/job/failed
execute unless score #localo oa.map2 = #expectedo oa.map2 run return run function oa:map/internal/job/failed
scoreboard players operation #chests oa.map2 += #localc oa.map2
scoreboard players operation #ores oa.map2 += #localo oa.map2
function oa:maps/end/tiles/release/72
scoreboard players add #tile oa.map2 1
execute store result storage oa_map2:args tile int 1 run scoreboard players get #tile oa.map2
execute if score #tile oa.map2 matches 100.. run return run function oa:map/internal/job/finish
schedule function oa:map/internal/job/next 1t replace
