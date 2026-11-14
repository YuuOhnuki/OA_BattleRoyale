execute if score #mode oa.map2 matches 0 run function oa:maps/cave/tiles/place/53
execute if score #state oa.map2 matches 2 run return 0
execute positioned ~-56 ~-40 ~8 run kill @e[type=minecraft:marker,tag=br.chest,dx=31,dy=40,dz=31]
execute positioned ~-56 ~-40 ~8 run kill @e[type=minecraft:marker,tag=br.ore,dx=31,dy=40,dz=31]
scoreboard players set #stage oa.map2 2
scoreboard players set #expectedc oa.map2 3
scoreboard players set #expectedo oa.map2 5
scoreboard players set #localc oa.map2 0
scoreboard players set #localo oa.map2 0
execute positioned ~-53 ~-28 ~20 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute positioned ~-29 ~-28 ~13 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute positioned ~-36 ~-27 ~36 if block ~ ~ ~ minecraft:redstone_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_3
execute positioned ~-50 ~-28 ~30 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute positioned ~-31 ~-27 ~22 if block ~ ~ ~ minecraft:redstone_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_3
execute positioned ~-47 ~-28 ~30 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute positioned ~-40 ~-28 ~39 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute positioned ~-31 ~-28 ~27 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #mode oa.map2 matches 0 positioned ~-47 ~-28 ~30 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #mode oa.map2 matches 0 positioned ~-40 ~-28 ~39 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #mode oa.map2 matches 0 positioned ~-31 ~-28 ~27 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute unless score #localc oa.map2 matches 3 run return run function oa:map/internal/job/failed
execute unless score #localo oa.map2 matches 5 run return run function oa:map/internal/job/failed
scoreboard players operation #chests oa.map2 += #localc oa.map2
scoreboard players operation #ores oa.map2 += #localo oa.map2
function oa:maps/cave/tiles/release/53
scoreboard players add #tile oa.map2 1
execute store result storage oa_map2:args tile int 1 run scoreboard players get #tile oa.map2
execute if score #tile oa.map2 matches 100.. run return run function oa:map/internal/job/finish
schedule function oa:map/internal/job/next 1t replace
