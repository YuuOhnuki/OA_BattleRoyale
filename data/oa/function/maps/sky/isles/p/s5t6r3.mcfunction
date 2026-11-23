# 生成: scripts/build_map_sky.py（直接編集しない）。候補地 5（-120,-19）に「飛行船の島」を向き counterclockwise_90 で置き、登録する（oa:br_sky で）
execute unless score #mode oa.map2 matches 1 in oa:br_sky run function oa:maps/sky/isles/bridge/s5
execute unless score #mode oa.map2 matches 1 in oa:br_sky store success score #isle_placed oa.map2 run place template oa:sky/ship -150 40 11 counterclockwise_90
execute unless score #mode oa.map2 matches 1 if score #isle_placed oa.map2 matches 0 run tellraw @a[tag=br.admin] {text:"[天空島] 「飛行船の島」を置けませんでした（読み込み）",color:"red"}
execute unless score #mode oa.map2 matches 1 in oa:br_sky store success score #dome_placed oa.map2 run place template oa:sky/dome_s5 -150 40 -49
execute unless score #mode oa.map2 matches 1 if score #dome_placed oa.map2 matches 0 run scoreboard players set #map_failed oa.map2 1
execute unless score #mode oa.map2 matches 1 if score #isle_placed oa.map2 matches 0 run scoreboard players set #map_failed oa.map2 1
execute in oa:br_sky positioned -113 81 -13 if block ~ ~ ~ minecraft:redstone_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_3
execute in oa:br_sky positioned -126 84 -24 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute in oa:br_sky positioned -132 81 -20 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute in oa:br_sky positioned -131 81 -11 if block ~ ~ ~ minecraft:redstone_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_3
execute in oa:br_sky positioned -131 81 -12 if block ~ ~ ~ minecraft:redstone_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_3
execute in oa:br_sky positioned -130 81 -11 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute in oa:br_sky positioned -119 81 0 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest_rich
execute unless score #mode oa.map2 matches 1 in oa:br_sky positioned -119 81 0 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_site
execute in oa:br_sky positioned -124 81 -3 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute unless score #mode oa.map2 matches 1 in oa:br_sky positioned -124 81 -3 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute in oa:br_sky positioned -123 81 -21 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute unless score #mode oa.map2 matches 1 in oa:br_sky positioned -123 81 -21 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute in oa:br_sky positioned -117 81 -29 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute unless score #mode oa.map2 matches 1 in oa:br_sky positioned -117 81 -29 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute in oa:br_sky positioned -117 81 -11 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute unless score #mode oa.map2 matches 1 in oa:br_sky positioned -117 81 -11 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute in oa:br_sky positioned -107 81 -24 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute unless score #mode oa.map2 matches 1 in oa:br_sky positioned -107 81 -24 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute in oa:br_sky positioned -131 81 -9 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute unless score #mode oa.map2 matches 1 in oa:br_sky positioned -131 81 -9 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
data modify storage oa:spawn_points points append value {x:-117.5d,y:81.0d,z:-39.5d}
data modify storage oa:spawn_points points append value {x:-134.5d,y:81.0d,z:-16.5d}
data modify storage oa:spawn_points points append value {x:-128.5d,y:81.0d,z:-30.5d}
data modify storage oa:spawn_points points append value {x:-110.5d,y:81.0d,z:5.5d}
data modify storage oa:spawn_points points append value {x:-145.5d,y:81.0d,z:-26.5d}
execute unless score #mode oa.map2 matches 1 in oa:br_sky run summon minecraft:block_display -120.5 96 -19.5 {Tags:["oa.isle"],block_state:"minecraft:white_wool",view_range:6.0f,Rotation:[0.0f,0.0f],transformation:{translation:[-4.000f,0.000f,-16.000f],left_rotation:[0.0f,0.0f,0.0f,1.0f],scale:[8.000f,6.000f,32.000f],right_rotation:[0.0f,0.0f,0.0f,1.0f]}}
execute unless score #mode oa.map2 matches 1 in oa:br_sky run summon minecraft:block_display -120.5 96 -19.5 {Tags:["oa.isle"],block_state:"minecraft:red_wool",view_range:6.0f,Rotation:[0.0f,0.0f],transformation:{translation:[-4.200f,2.200f,-16.200f],left_rotation:[0.0f,0.0f,0.0f,1.0f],scale:[8.400f,1.200f,32.400f],right_rotation:[0.0f,0.0f,0.0f,1.0f]}}
execute unless score #mode oa.map2 matches 1 in oa:br_sky run summon minecraft:block_display -120.5 81 -5.5 {Tags:["oa.isle"],block_state:"minecraft:oak_fence",view_range:6.0f,Rotation:[270.0f,0.0f],transformation:{translation:[-0.075f,0.000f,-0.075f],left_rotation:[0.0f,0.0f,0.0f,1.0f],scale:[0.150f,15.000f,0.150f],right_rotation:[0.0f,0.0f,0.0f,1.0f]}}
execute unless score #mode oa.map2 matches 1 in oa:br_sky run summon minecraft:block_display -120.5 81 -19.5 {Tags:["oa.isle"],block_state:"minecraft:oak_fence",view_range:6.0f,Rotation:[270.0f,0.0f],transformation:{translation:[-0.075f,0.000f,-0.075f],left_rotation:[0.0f,0.0f,0.0f,1.0f],scale:[0.150f,15.000f,0.150f],right_rotation:[0.0f,0.0f,0.0f,1.0f]}}
execute unless score #mode oa.map2 matches 1 in oa:br_sky run summon minecraft:block_display -120.5 81 -33.5 {Tags:["oa.isle"],block_state:"minecraft:oak_fence",view_range:6.0f,Rotation:[270.0f,0.0f],transformation:{translation:[-0.075f,0.000f,-0.075f],left_rotation:[0.0f,0.0f,0.0f,1.0f],scale:[0.150f,15.000f,0.150f],right_rotation:[0.0f,0.0f,0.0f,1.0f]}}
data modify storage oa:maps layout.sky append value {x:-120,z:-19,name:"飛行船の島"}
data modify storage oa:maps sky_region.s5 set value "飛行船の島のあたり"
data modify storage oa:maps sky_isles append value "飛行船の島"
