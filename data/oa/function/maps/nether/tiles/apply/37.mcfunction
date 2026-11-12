execute if score #mode oa.map2 matches 0 run function oa:maps/nether/tiles/place/37
execute if score #state oa.map2 matches 2 run return 0
execute positioned ~72 ~-20 ~-56 run kill @e[type=minecraft:marker,tag=br.chest,dx=31,dy=20,dz=31]
execute positioned ~72 ~-20 ~-56 run kill @e[type=minecraft:marker,tag=br.ore,dx=31,dy=20,dz=31]
scoreboard players set #stage oa.map2 2
scoreboard players set #expectedc oa.map2 2
scoreboard players set #expectedo oa.map2 3
scoreboard players set #localc oa.map2 0
scoreboard players set #localo oa.map2 0
execute positioned ~100 ~-13 ~-42 if block ~ ~ ~ minecraft:redstone_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_3
execute positioned ~77 ~-11 ~-26 if block ~ ~ ~ minecraft:redstone_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_3
execute positioned ~99 ~-11 ~-33 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute positioned ~93 ~-11 ~-51 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest_rich
execute positioned ~93 ~-11 ~-55 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #mode oa.map2 matches 0 positioned ~93 ~-11 ~-51 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_site
execute if score #mode oa.map2 matches 0 positioned ~93 ~-11 ~-55 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute unless score #localc oa.map2 matches 2 run return run function oa:map/internal/job/failed
execute unless score #localo oa.map2 matches 3 run return run function oa:map/internal/job/failed
scoreboard players operation #chests oa.map2 += #localc oa.map2
scoreboard players operation #ores oa.map2 += #localo oa.map2
function oa:maps/nether/tiles/release/37
scoreboard players add #tile oa.map2 1
execute store result storage oa_map2:args tile int 1 run scoreboard players get #tile oa.map2
execute if score #tile oa.map2 matches 100.. run return run function oa:map/internal/job/finish
schedule function oa:map/internal/job/next 1t replace
