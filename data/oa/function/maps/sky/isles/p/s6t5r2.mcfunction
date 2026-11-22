# 生成: scripts/build_map_sky.py（直接編集しない）。候補地 6（-78,-78）に「和風の島」を向き 180 で置き、登録する（oa:br_sky で）
execute unless score #mode oa.map2 matches 1 in oa:br_sky run function oa:maps/sky/isles/bridge/s6
execute unless score #mode oa.map2 matches 1 in oa:br_sky store success score #isle_placed oa.map2 run place template oa:sky/japan -48 40 -48 180
execute unless score #mode oa.map2 matches 1 if score #isle_placed oa.map2 matches 0 run tellraw @a[tag=br.admin] {text:"[天空島] 「和風の島」を置けませんでした（読み込み）",color:"red"}
execute unless score #mode oa.map2 matches 1 in oa:br_sky run place template oa:sky/dome_s6 -108 40 -108
execute in oa:br_sky positioned -71 81 -98 if block ~ ~ ~ minecraft:redstone_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_3
execute in oa:br_sky positioned -82 89 -78 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute in oa:br_sky positioned -96 82 -75 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute in oa:br_sky positioned -67 81 -60 if block ~ ~ ~ minecraft:redstone_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_3
execute in oa:br_sky positioned -72 83 -72 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest_rich
execute unless score #mode oa.map2 matches 1 in oa:br_sky positioned -72 83 -72 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_site
execute in oa:br_sky positioned -85 87 -66 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute unless score #mode oa.map2 matches 1 in oa:br_sky positioned -85 87 -66 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute in oa:br_sky positioned -93 83 -86 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute unless score #mode oa.map2 matches 1 in oa:br_sky positioned -93 83 -86 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute in oa:br_sky positioned -69 85 -81 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute unless score #mode oa.map2 matches 1 in oa:br_sky positioned -69 85 -81 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute in oa:br_sky positioned -95 81 -71 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute unless score #mode oa.map2 matches 1 in oa:br_sky positioned -95 81 -71 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute in oa:br_sky positioned -70 85 -83 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute unless score #mode oa.map2 matches 1 in oa:br_sky positioned -70 85 -83 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute in oa:br_sky positioned -72 82 -60 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute unless score #mode oa.map2 matches 1 in oa:br_sky positioned -72 82 -60 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
data modify storage oa:spawn_points points append value {x:-58.5d,y:81.0d,z:-69.5d}
data modify storage oa:spawn_points points append value {x:-90.5d,y:81.0d,z:-57.5d}
data modify storage oa:spawn_points points append value {x:-72.5d,y:81.0d,z:-101.5d}
data modify storage oa:spawn_points points append value {x:-100.5d,y:81.0d,z:-70.5d}
data modify storage oa:spawn_points points append value {x:-62.5d,y:81.0d,z:-95.5d}
data modify storage oa:maps layout.sky append value {x:-78,z:-78,name:"和風の島"}
data modify storage oa:maps sky_region.s6 set value "和風の島のあたり"
data modify storage oa:maps sky_isles append value "和風の島"
