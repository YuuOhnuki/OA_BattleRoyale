execute if score #mode oa.map2 matches 0 run function oa:maps/nether/tiles/place/22
execute if score #state oa.map2 matches 2 run return 0
execute positioned ~-88 ~-20 ~-88 run kill @e[type=minecraft:marker,tag=br.chest,dx=31,dy=20,dz=31]
execute positioned ~-88 ~-20 ~-88 run kill @e[type=minecraft:marker,tag=br.ore,dx=31,dy=20,dz=31]
scoreboard players set #stage oa.map2 2
scoreboard players set #expectedc oa.map2 2
scoreboard players set #expectedo oa.map2 4
scoreboard players set #localc oa.map2 0
scoreboard players set #localo oa.map2 0
execute positioned ~-78 ~-11 ~-77 if block ~ ~ ~ minecraft:nether_gold_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_6
execute positioned ~-73 ~-11 ~-58 if block ~ ~ ~ minecraft:nether_gold_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_6
execute positioned ~-72 ~-11 ~-73 if block ~ ~ ~ minecraft:nether_quartz_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_5
execute positioned ~-72 ~-11 ~-84 if block ~ ~ ~ minecraft:nether_gold_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_6
execute positioned ~-61 ~-11 ~-57 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute positioned ~-58 ~-11 ~-82 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #mode oa.map2 matches 0 positioned ~-61 ~-11 ~-57 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #mode oa.map2 matches 0 positioned ~-58 ~-11 ~-82 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute unless score #localc oa.map2 matches 2 run return run function oa:map/internal/job/failed
execute unless score #localo oa.map2 matches 4 run return run function oa:map/internal/job/failed
scoreboard players operation #chests oa.map2 += #localc oa.map2
scoreboard players operation #ores oa.map2 += #localo oa.map2
function oa:maps/nether/tiles/release/22
scoreboard players add #tile oa.map2 1
execute store result storage oa_map2:args tile int 1 run scoreboard players get #tile oa.map2
execute if score #tile oa.map2 matches 100.. run return run function oa:map/internal/job/finish
schedule function oa:map/internal/job/next 1t replace
