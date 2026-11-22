execute if score #mode oa.map2 matches 0 run function oa:maps/sky/tiles/place/47
execute if score #state oa.map2 matches 2 run return 0
execute positioned ~72 ~-40 ~-24 run kill @e[type=minecraft:marker,tag=br.chest,dx=31,dy=80,dz=31]
execute positioned ~72 ~-40 ~-24 run kill @e[type=minecraft:marker,tag=br.ore,dx=31,dy=80,dz=31]
execute positioned ~72 ~-40 ~-24 run kill @e[type=minecraft:marker,tag=oa.gim,dx=31,dy=80,dz=31]
execute positioned ~72 ~-40 ~-24 run kill @e[type=minecraft:block_display,tag=oa.mdeco,dx=31,dy=80,dz=31]
scoreboard players set #stage oa.map2 2
scoreboard players set #localc oa.map2 0
scoreboard players set #localo oa.map2 0
scoreboard players set #expectedc oa.map2 0
scoreboard players set #expectedo oa.map2 0
execute positioned ~87 ~1 ~-18 align xyz positioned ~0.5 ~0 ~0.5 run summon minecraft:marker ~ ~ ~ {Tags:["oa.gim","oa.gim_tp","oa.gim_tp_-172_0_24"]}
execute if score #sv0 oa.map2 matches 0 run scoreboard players add #expectedc oa.map2 5
execute if score #sv0 oa.map2 matches 0 run scoreboard players add #expectedo oa.map2 3
execute if score #sv0 oa.map2 matches 0 positioned ~85 ~1 ~-2 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv0 oa.map2 matches 0 positioned ~89 ~1 ~-11 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv0 oa.map2 matches 0 positioned ~88 ~1 ~-11 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv0 oa.map2 matches 0 positioned ~95 ~1 ~-8 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest_rich
execute if score #sv0 oa.map2 matches 0 positioned ~90 ~1 ~-6 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv0 oa.map2 matches 0 positioned ~98 ~1 ~-21 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv0 oa.map2 matches 0 positioned ~103 ~1 ~-15 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv0 oa.map2 matches 0 positioned ~97 ~1 ~0 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv0 oa.map2 matches 0 if score #mode oa.map2 matches 0 positioned ~95 ~1 ~-8 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_site
execute if score #sv0 oa.map2 matches 0 if score #mode oa.map2 matches 0 positioned ~90 ~1 ~-6 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv0 oa.map2 matches 0 if score #mode oa.map2 matches 0 positioned ~98 ~1 ~-21 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv0 oa.map2 matches 0 if score #mode oa.map2 matches 0 positioned ~103 ~1 ~-15 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv0 oa.map2 matches 0 if score #mode oa.map2 matches 0 positioned ~97 ~1 ~0 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv0 oa.map2 matches 1 run scoreboard players add #expectedc oa.map2 4
execute if score #sv0 oa.map2 matches 1 run scoreboard players add #expectedo oa.map2 4
execute if score #sv0 oa.map2 matches 1 positioned ~99 ~1 ~-13 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv0 oa.map2 matches 1 positioned ~97 ~1 ~-2 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv0 oa.map2 matches 1 positioned ~87 ~1 ~-7 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv0 oa.map2 matches 1 positioned ~94 ~1 ~-13 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv0 oa.map2 matches 1 positioned ~93 ~1 ~-10 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv0 oa.map2 matches 1 positioned ~96 ~1 ~-10 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv0 oa.map2 matches 1 positioned ~103 ~1 ~-12 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv0 oa.map2 matches 1 positioned ~93 ~1 ~-3 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv0 oa.map2 matches 1 if score #mode oa.map2 matches 0 positioned ~93 ~1 ~-10 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv0 oa.map2 matches 1 if score #mode oa.map2 matches 0 positioned ~96 ~1 ~-10 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv0 oa.map2 matches 1 if score #mode oa.map2 matches 0 positioned ~103 ~1 ~-12 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv0 oa.map2 matches 1 if score #mode oa.map2 matches 0 positioned ~93 ~1 ~-3 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv0 oa.map2 matches 2 run scoreboard players add #expectedc oa.map2 5
execute if score #sv0 oa.map2 matches 2 run scoreboard players add #expectedo oa.map2 5
execute if score #sv0 oa.map2 matches 2 positioned ~103 ~1 ~-3 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv0 oa.map2 matches 2 positioned ~89 ~1 ~-1 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv0 oa.map2 matches 2 positioned ~97 ~1 ~-2 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv0 oa.map2 matches 2 positioned ~100 ~1 ~-4 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv0 oa.map2 matches 2 positioned ~89 ~1 ~-4 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv0 oa.map2 matches 2 positioned ~96 ~13 ~-7 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv0 oa.map2 matches 2 positioned ~96 ~1 ~-7 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv0 oa.map2 matches 2 positioned ~95 ~1 ~-18 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv0 oa.map2 matches 2 positioned ~98 ~1 ~-14 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv0 oa.map2 matches 2 positioned ~89 ~1 ~-12 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv0 oa.map2 matches 2 if score #mode oa.map2 matches 0 positioned ~96 ~13 ~-7 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv0 oa.map2 matches 2 if score #mode oa.map2 matches 0 positioned ~96 ~1 ~-7 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv0 oa.map2 matches 2 if score #mode oa.map2 matches 0 positioned ~95 ~1 ~-18 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv0 oa.map2 matches 2 if score #mode oa.map2 matches 0 positioned ~98 ~1 ~-14 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv0 oa.map2 matches 2 if score #mode oa.map2 matches 0 positioned ~89 ~1 ~-12 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute unless score #localc oa.map2 = #expectedc oa.map2 run return run function oa:map/internal/job/failed
execute unless score #localo oa.map2 = #expectedo oa.map2 run return run function oa:map/internal/job/failed
scoreboard players operation #chests oa.map2 += #localc oa.map2
scoreboard players operation #ores oa.map2 += #localo oa.map2
function oa:maps/sky/tiles/release/47
scoreboard players add #tile oa.map2 1
execute store result storage oa_map2:args tile int 1 run scoreboard players get #tile oa.map2
execute if score #tile oa.map2 matches 100.. run return run function oa:map/internal/job/finish
schedule function oa:map/internal/job/next 1t replace
