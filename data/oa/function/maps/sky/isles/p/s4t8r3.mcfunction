# 生成: scripts/build_map_sky.py（直接編集しない）。候補地 4（-98,50）に「天空神殿の島」を向き counterclockwise_90 で置き、登録する（oa:br_sky で）
execute unless score #mode oa.map2 matches 1 in oa:br_sky run function oa:maps/sky/isles/bridge/s4
execute unless score #mode oa.map2 matches 1 in oa:br_sky store success score #isle_placed oa.map2 run place template oa:sky/temple -128 40 80 counterclockwise_90
execute unless score #mode oa.map2 matches 1 if score #isle_placed oa.map2 matches 0 run tellraw @a[tag=br.admin] {text:"[天空島] 「天空神殿の島」を置けませんでした（読み込み）",color:"red"}
execute unless score #mode oa.map2 matches 1 in oa:br_sky run place template oa:sky/dome_s4 -128 40 20
execute in oa:br_sky positioned -92 83 63 if block ~ ~ ~ minecraft:redstone_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_3
execute in oa:br_sky positioned -106 83 62 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute in oa:br_sky positioned -94 83 62 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute in oa:br_sky positioned -111 81 48 if block ~ ~ ~ minecraft:redstone_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_3
execute in oa:br_sky positioned -98 86 50 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest_rich
execute unless score #mode oa.map2 matches 1 in oa:br_sky positioned -98 86 50 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_site
execute in oa:br_sky positioned -92 83 36 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute unless score #mode oa.map2 matches 1 in oa:br_sky positioned -92 83 36 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute in oa:br_sky positioned -113 81 54 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute unless score #mode oa.map2 matches 1 in oa:br_sky positioned -113 81 54 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute in oa:br_sky positioned -94 81 32 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute unless score #mode oa.map2 matches 1 in oa:br_sky positioned -94 81 32 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute in oa:br_sky positioned -88 83 61 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute unless score #mode oa.map2 matches 1 in oa:br_sky positioned -88 83 61 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute in oa:br_sky positioned -110 83 39 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute unless score #mode oa.map2 matches 1 in oa:br_sky positioned -110 83 39 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute in oa:br_sky positioned -87 83 38 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute unless score #mode oa.map2 matches 1 in oa:br_sky positioned -87 83 38 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
data modify storage oa:spawn_points points append value {x:-79.5d,y:81.0d,z:44.5d}
data modify storage oa:spawn_points points append value {x:-123.5d,y:81.0d,z:47.5d}
data modify storage oa:spawn_points points append value {x:-115.5d,y:81.0d,z:54.5d}
data modify storage oa:spawn_points points append value {x:-90.5d,y:81.0d,z:70.5d}
data modify storage oa:spawn_points points append value {x:-96.5d,y:81.0d,z:72.5d}
data modify storage oa:maps layout.sky append value {x:-98,z:50,name:"天空神殿の島"}
data modify storage oa:maps sky_region.s4 set value "天空神殿の島のあたり"
data modify storage oa:maps sky_isles append value "天空神殿の島"
