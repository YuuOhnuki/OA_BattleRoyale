execute if score #mode oa.map2 matches 0 run function oa:maps/sky/tiles/place/24
execute if score #state oa.map2 matches 2 run return 0
execute positioned ~-24 ~-40 ~-88 run kill @e[type=minecraft:marker,tag=br.chest,dx=31,dy=80,dz=31]
execute positioned ~-24 ~-40 ~-88 run kill @e[type=minecraft:marker,tag=br.ore,dx=31,dy=80,dz=31]
execute positioned ~-24 ~-40 ~-88 run kill @e[type=minecraft:marker,tag=oa.gim,dx=31,dy=80,dz=31]
scoreboard players set #stage oa.map2 2
scoreboard players set #localc oa.map2 0
scoreboard players set #localo oa.map2 0
scoreboard players set #expectedc oa.map2 0
scoreboard players set #expectedo oa.map2 0
execute positioned ~6 ~1 ~-75 align xyz positioned ~0.5 ~0 ~0.5 run summon minecraft:marker ~ ~ ~ {Tags:["oa.gim","oa.gim_tp","oa.gim_tp_-11_0_149"]}
execute if score #sv6 oa.map2 matches 0 run scoreboard players add #expectedc oa.map2 1
execute if score #sv6 oa.map2 matches 0 run scoreboard players add #expectedo oa.map2 2
execute if score #sv6 oa.map2 matches 0 positioned ~-3 ~1 ~-88 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv6 oa.map2 matches 0 positioned ~3 ~1 ~-85 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv6 oa.map2 matches 0 positioned ~-3 ~1 ~-77 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv6 oa.map2 matches 0 if score #mode oa.map2 matches 0 positioned ~-3 ~1 ~-77 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv6 oa.map2 matches 1 run scoreboard players add #expectedc oa.map2 3
execute if score #sv6 oa.map2 matches 1 positioned ~1 ~1 ~-84 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv6 oa.map2 matches 1 positioned ~4 ~1 ~-85 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv6 oa.map2 matches 1 positioned ~7 ~1 ~-82 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv6 oa.map2 matches 1 if score #mode oa.map2 matches 0 positioned ~1 ~1 ~-84 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv6 oa.map2 matches 1 if score #mode oa.map2 matches 0 positioned ~4 ~1 ~-85 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv6 oa.map2 matches 1 if score #mode oa.map2 matches 0 positioned ~7 ~1 ~-82 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv6 oa.map2 matches 2 run scoreboard players add #expectedc oa.map2 2
execute if score #sv6 oa.map2 matches 2 run scoreboard players add #expectedo oa.map2 1
execute if score #sv6 oa.map2 matches 2 positioned ~5 ~1 ~-85 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv6 oa.map2 matches 2 positioned ~5 ~1 ~-87 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv6 oa.map2 matches 2 positioned ~1 ~1 ~-83 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #sv6 oa.map2 matches 2 if score #mode oa.map2 matches 0 positioned ~5 ~1 ~-87 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #sv6 oa.map2 matches 2 if score #mode oa.map2 matches 0 positioned ~1 ~1 ~-83 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute unless score #localc oa.map2 = #expectedc oa.map2 run return run function oa:map/internal/job/failed
execute unless score #localo oa.map2 = #expectedo oa.map2 run return run function oa:map/internal/job/failed
scoreboard players operation #chests oa.map2 += #localc oa.map2
scoreboard players operation #ores oa.map2 += #localo oa.map2
function oa:maps/sky/tiles/release/24
scoreboard players add #tile oa.map2 1
execute store result storage oa_map2:args tile int 1 run scoreboard players get #tile oa.map2
execute if score #tile oa.map2 matches 100.. run return run function oa:map/internal/job/finish
schedule function oa:map/internal/job/next 1t replace
