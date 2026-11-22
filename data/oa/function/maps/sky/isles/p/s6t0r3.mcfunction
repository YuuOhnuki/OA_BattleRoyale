# 生成: scripts/build_map_sky.py（直接編集しない）。候補地 6（-78,-78）に「砂漠の島」を向き counterclockwise_90 で置き、登録する（oa:br_sky で）
execute unless score #mode oa.map2 matches 1 in oa:br_sky run function oa:maps/sky/isles/bridge/s6
execute unless score #mode oa.map2 matches 1 in oa:br_sky store success score #isle_placed oa.map2 run place template oa:sky/desert -108 40 -48 counterclockwise_90
execute unless score #mode oa.map2 matches 1 if score #isle_placed oa.map2 matches 0 run tellraw @a[tag=br.admin] {text:"[天空島] 「砂漠の島」を置けませんでした（読み込み）",color:"red"}
execute unless score #mode oa.map2 matches 1 in oa:br_sky run place template oa:sky/dome_s6 -108 40 -108
execute in oa:br_sky positioned -86 84 -88 if block ~ ~ ~ minecraft:redstone_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_3
execute in oa:br_sky positioned -71 81 -64 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute in oa:br_sky positioned -94 81 -86 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute in oa:br_sky positioned -72 81 -61 if block ~ ~ ~ minecraft:redstone_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_3
execute in oa:br_sky positioned -84 84 -74 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest_rich
execute unless score #mode oa.map2 matches 1 in oa:br_sky positioned -84 84 -74 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_site
execute in oa:br_sky positioned -89 84 -87 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute unless score #mode oa.map2 matches 1 in oa:br_sky positioned -89 84 -87 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute in oa:br_sky positioned -72 85 -85 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute unless score #mode oa.map2 matches 1 in oa:br_sky positioned -72 85 -85 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute in oa:br_sky positioned -80 88 -87 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute unless score #mode oa.map2 matches 1 in oa:br_sky positioned -80 88 -87 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute in oa:br_sky positioned -67 81 -63 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute unless score #mode oa.map2 matches 1 in oa:br_sky positioned -67 81 -63 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute in oa:br_sky positioned -87 81 -61 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute unless score #mode oa.map2 matches 1 in oa:br_sky positioned -87 81 -61 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute in oa:br_sky positioned -78 81 -57 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute unless score #mode oa.map2 matches 1 in oa:br_sky positioned -78 81 -57 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
data modify storage oa:spawn_points points append value {x:-57.5d,y:81.0d,z:-65.5d}
data modify storage oa:spawn_points points append value {x:-91.5d,y:84.0d,z:-70.5d}
data modify storage oa:spawn_points points append value {x:-94.5d,y:81.0d,z:-89.5d}
data modify storage oa:spawn_points points append value {x:-81.5d,y:81.0d,z:-57.5d}
data modify storage oa:spawn_points points append value {x:-91.5d,y:81.0d,z:-57.5d}
data modify storage oa:maps layout.sky append value {x:-78,z:-78,name:"砂漠の島"}
data modify storage oa:maps sky_region.s6 set value "砂漠の島のあたり"
data modify storage oa:maps sky_isles append value "砂漠の島"
