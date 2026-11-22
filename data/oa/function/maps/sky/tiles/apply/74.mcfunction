execute if score #mode oa.map2 matches 0 run function oa:maps/sky/tiles/place/74
execute if score #state oa.map2 matches 2 run return 0
execute positioned ~-24 ~-40 ~72 run kill @e[type=minecraft:marker,tag=br.chest,dx=31,dy=80,dz=31]
execute positioned ~-24 ~-40 ~72 run kill @e[type=minecraft:marker,tag=br.ore,dx=31,dy=80,dz=31]
execute positioned ~-24 ~-40 ~72 run kill @e[type=minecraft:marker,tag=oa.gim,dx=31,dy=80,dz=31]
execute positioned ~-24 ~-40 ~72 run kill @e[type=minecraft:block_display,tag=oa.mdeco,dx=31,dy=80,dz=31]
scoreboard players set #stage oa.map2 2
scoreboard players set #localc oa.map2 0
scoreboard players set #localo oa.map2 0
scoreboard players set #expectedc oa.map2 0
scoreboard players set #expectedo oa.map2 0
execute if score #sv2 oa.map2 matches 0 run scoreboard players add #expectedc oa.map2 7
execute if score #sv2 oa.map2 matches 0 run scoreboard players add #expectedo oa.map2 5
execute if score #sv2 oa.map2 matches 0 positioned ~-5 ~1 ~103 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv2 oa.map2 matches 0 positioned ~-21 ~6 ~99 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv2 oa.map2 matches 0 positioned ~-23 ~1 ~94 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv2 oa.map2 matches 0 positioned ~-5 ~1 ~83 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv2 oa.map2 matches 0 positioned ~-2 ~1 ~87 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv2 oa.map2 matches 0 positioned ~-11 ~1 ~89 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv2 oa.map2 matches 0 positioned ~-9 ~1 ~89 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv2 oa.map2 matches 0 positioned ~-10 ~5 ~96 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv2 oa.map2 matches 0 positioned ~-2 ~5 ~96 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv2 oa.map2 matches 0 positioned ~-15 ~1 ~101 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv2 oa.map2 matches 0 positioned ~-1 ~1 ~103 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv2 oa.map2 matches 0 positioned ~-12 ~1 ~99 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv2 oa.map2 matches 0 if score #mode oa.map2 matches 0 positioned ~-11 ~1 ~89 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv2 oa.map2 matches 0 if score #mode oa.map2 matches 0 positioned ~-9 ~1 ~89 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv2 oa.map2 matches 0 if score #mode oa.map2 matches 0 positioned ~-10 ~5 ~96 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv2 oa.map2 matches 0 if score #mode oa.map2 matches 0 positioned ~-2 ~5 ~96 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv2 oa.map2 matches 0 if score #mode oa.map2 matches 0 positioned ~-15 ~1 ~101 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv2 oa.map2 matches 0 if score #mode oa.map2 matches 0 positioned ~-1 ~1 ~103 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv2 oa.map2 matches 0 if score #mode oa.map2 matches 0 positioned ~-12 ~1 ~99 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv2 oa.map2 matches 1 run scoreboard players add #expectedc oa.map2 7
execute if score #sv2 oa.map2 matches 1 run scoreboard players add #expectedo oa.map2 5
execute if score #sv2 oa.map2 matches 1 positioned ~-11 ~1 ~96 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv2 oa.map2 matches 1 positioned ~-3 ~1 ~103 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv2 oa.map2 matches 1 positioned ~-10 ~1 ~86 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv2 oa.map2 matches 1 positioned ~-15 ~1 ~93 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv2 oa.map2 matches 1 positioned ~1 ~1 ~96 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv2 oa.map2 matches 1 positioned ~-12 ~1 ~89 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv2 oa.map2 matches 1 positioned ~0 ~1 ~89 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv2 oa.map2 matches 1 positioned ~-12 ~1 ~97 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv2 oa.map2 matches 1 positioned ~0 ~1 ~97 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv2 oa.map2 matches 1 positioned ~-3 ~1 ~100 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv2 oa.map2 matches 1 positioned ~-8 ~1 ~101 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv2 oa.map2 matches 1 positioned ~-18 ~1 ~94 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv2 oa.map2 matches 1 if score #mode oa.map2 matches 0 positioned ~-12 ~1 ~89 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv2 oa.map2 matches 1 if score #mode oa.map2 matches 0 positioned ~0 ~1 ~89 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv2 oa.map2 matches 1 if score #mode oa.map2 matches 0 positioned ~-12 ~1 ~97 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv2 oa.map2 matches 1 if score #mode oa.map2 matches 0 positioned ~0 ~1 ~97 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv2 oa.map2 matches 1 if score #mode oa.map2 matches 0 positioned ~-3 ~1 ~100 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv2 oa.map2 matches 1 if score #mode oa.map2 matches 0 positioned ~-8 ~1 ~101 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv2 oa.map2 matches 1 if score #mode oa.map2 matches 0 positioned ~-18 ~1 ~94 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv2 oa.map2 matches 2 run scoreboard players add #expectedc oa.map2 4
execute if score #sv2 oa.map2 matches 2 run scoreboard players add #expectedo oa.map2 5
execute if score #sv2 oa.map2 matches 2 positioned ~-19 ~2 ~96 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv2 oa.map2 matches 2 positioned ~-15 ~3 ~82 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv2 oa.map2 matches 2 positioned ~-2 ~1 ~101 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv2 oa.map2 matches 2 positioned ~-17 ~1 ~83 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv2 oa.map2 matches 2 positioned ~-3 ~1 ~100 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv2 oa.map2 matches 2 positioned ~-8 ~1 ~91 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv2 oa.map2 matches 2 positioned ~-12 ~1 ~101 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv2 oa.map2 matches 2 positioned ~-13 ~1 ~99 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv2 oa.map2 matches 2 positioned ~-17 ~5 ~102 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv2 oa.map2 matches 2 if score #mode oa.map2 matches 0 positioned ~-8 ~1 ~91 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv2 oa.map2 matches 2 if score #mode oa.map2 matches 0 positioned ~-12 ~1 ~101 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv2 oa.map2 matches 2 if score #mode oa.map2 matches 0 positioned ~-13 ~1 ~99 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv2 oa.map2 matches 2 if score #mode oa.map2 matches 0 positioned ~-17 ~5 ~102 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute unless score #localc oa.map2 = #expectedc oa.map2 run return run function oa:map/internal/job/failed
execute unless score #localo oa.map2 = #expectedo oa.map2 run return run function oa:map/internal/job/failed
scoreboard players operation #chests oa.map2 += #localc oa.map2
scoreboard players operation #ores oa.map2 += #localo oa.map2
function oa:maps/sky/tiles/release/74
scoreboard players add #tile oa.map2 1
execute store result storage oa_map2:args tile int 1 run scoreboard players get #tile oa.map2
execute if score #tile oa.map2 matches 100.. run return run function oa:map/internal/job/finish
schedule function oa:map/internal/job/next 1t replace
