# 生成: scripts/build_map_sky.py（直接編集しない）。候補地 0（109,17）に「砂漠の島」を向き 180 で置き、登録する（oa:br_sky で）
execute unless score #mode oa.map2 matches 1 in oa:br_sky run function oa:maps/sky/isles/bridge/s0
execute unless score #mode oa.map2 matches 1 in oa:br_sky store success score #isle_placed oa.map2 run place template oa:sky/desert 139 40 47 180
execute unless score #mode oa.map2 matches 1 if score #isle_placed oa.map2 matches 0 run tellraw @a[tag=br.admin] {text:"[天空島] 「砂漠の島」を置けませんでした（読み込み）",color:"red"}
execute unless score #mode oa.map2 matches 1 in oa:br_sky run place template oa:sky/dome_s0 79 40 -13
execute in oa:br_sky positioned 99 84 25 if block ~ ~ ~ minecraft:redstone_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_3
execute in oa:br_sky positioned 123 81 10 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute in oa:br_sky positioned 101 81 33 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute in oa:br_sky positioned 126 81 11 if block ~ ~ ~ minecraft:redstone_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_3
execute in oa:br_sky positioned 113 84 23 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest_rich
execute unless score #mode oa.map2 matches 1 in oa:br_sky positioned 113 84 23 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_site
execute in oa:br_sky positioned 100 84 28 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute unless score #mode oa.map2 matches 1 in oa:br_sky positioned 100 84 28 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute in oa:br_sky positioned 102 85 11 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute unless score #mode oa.map2 matches 1 in oa:br_sky positioned 102 85 11 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute in oa:br_sky positioned 100 88 19 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute unless score #mode oa.map2 matches 1 in oa:br_sky positioned 100 88 19 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute in oa:br_sky positioned 124 81 6 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute unless score #mode oa.map2 matches 1 in oa:br_sky positioned 124 81 6 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute in oa:br_sky positioned 126 81 26 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute unless score #mode oa.map2 matches 1 in oa:br_sky positioned 126 81 26 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute in oa:br_sky positioned 130 81 17 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute unless score #mode oa.map2 matches 1 in oa:br_sky positioned 130 81 17 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
data modify storage oa:spawn_points points append value {x:122.5d,y:81.0d,z:-4.5d}
data modify storage oa:spawn_points points append value {x:117.5d,y:84.0d,z:30.5d}
data modify storage oa:spawn_points points append value {x:98.5d,y:81.0d,z:33.5d}
data modify storage oa:spawn_points points append value {x:130.5d,y:81.0d,z:20.5d}
data modify storage oa:spawn_points points append value {x:130.5d,y:81.0d,z:30.5d}
data modify storage oa:maps layout.sky append value {x:109,z:17,name:"砂漠の島"}
data modify storage oa:maps sky_region.s0 set value "砂漠の島のあたり"
data modify storage oa:maps sky_isles append value "砂漠の島"
