# 生成: scripts/build_map_sky.py（直接編集しない）。候補地 8（50,-98）に「西洋の町の島」を向き counterclockwise_90 で置き、登録する（oa:br_sky で）
execute unless score #mode oa.map2 matches 1 in oa:br_sky run function oa:maps/sky/isles/bridge/s8
execute unless score #mode oa.map2 matches 1 in oa:br_sky store success score #isle_placed oa.map2 run place template oa:sky/western 20 40 -68 counterclockwise_90
execute unless score #mode oa.map2 matches 1 if score #isle_placed oa.map2 matches 0 run tellraw @a[tag=br.admin] {text:"[天空島] 「西洋の町の島」を置けませんでした（読み込み）",color:"red"}
execute unless score #mode oa.map2 matches 1 in oa:br_sky run place template oa:sky/dome_s8 20 40 -128
execute in oa:br_sky positioned 62 81 -114 if block ~ ~ ~ minecraft:redstone_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_3
execute in oa:br_sky positioned 44 84 -111 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute in oa:br_sky positioned 37 81 -81 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute in oa:br_sky positioned 39 81 -89 if block ~ ~ ~ minecraft:redstone_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_3
execute in oa:br_sky positioned 32 82 -95 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest_rich
execute unless score #mode oa.map2 matches 1 in oa:br_sky positioned 32 82 -95 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_site
execute in oa:br_sky positioned 54 84 -111 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute unless score #mode oa.map2 matches 1 in oa:br_sky positioned 54 84 -111 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute in oa:br_sky positioned 39 84 -110 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute unless score #mode oa.map2 matches 1 in oa:br_sky positioned 39 84 -110 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute in oa:br_sky positioned 54 84 -87 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute unless score #mode oa.map2 matches 1 in oa:br_sky positioned 54 84 -87 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute in oa:br_sky positioned 60 84 -99 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute unless score #mode oa.map2 matches 1 in oa:br_sky positioned 60 84 -99 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute in oa:br_sky positioned 41 84 -88 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute unless score #mode oa.map2 matches 1 in oa:br_sky positioned 41 84 -88 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute in oa:br_sky positioned 48 84 -107 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute unless score #mode oa.map2 matches 1 in oa:br_sky positioned 48 84 -107 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
data modify storage oa:spawn_points points append value {x:33.5d,y:81.0d,z:-111.5d}
data modify storage oa:spawn_points points append value {x:32.5d,y:81.0d,z:-80.5d}
data modify storage oa:spawn_points points append value {x:65.5d,y:81.0d,z:-112.5d}
data modify storage oa:spawn_points points append value {x:74.5d,y:81.0d,z:-99.5d}
data modify storage oa:spawn_points points append value {x:74.5d,y:81.0d,z:-89.5d}
data modify storage oa:maps layout.sky append value {x:50,z:-98,name:"西洋の町の島"}
data modify storage oa:maps sky_region.s8 set value "西洋の町の島のあたり"
data modify storage oa:maps sky_isles append value "西洋の町の島"
