# 生成: scripts/build_map_sky.py（直接編集しない）。候補地 3（-55,109）に「飛行船の島」を向き clockwise_90 で置き、登録する（oa:br_sky で）
execute unless score #mode oa.map2 matches 1 in oa:br_sky run function oa:maps/sky/isles/bridge/s3
execute unless score #mode oa.map2 matches 1 in oa:br_sky store success score #isle_placed oa.map2 run place template oa:sky/ship -25 40 79 clockwise_90
execute unless score #mode oa.map2 matches 1 if score #isle_placed oa.map2 matches 0 run tellraw @a[tag=br.admin] {text:"[天空島] 「飛行船の島」を置けませんでした（読み込み）",color:"red"}
execute unless score #mode oa.map2 matches 1 in oa:br_sky store success score #dome_placed oa.map2 run place template oa:sky/dome_s3 -85 40 79
execute unless score #mode oa.map2 matches 1 if score #dome_placed oa.map2 matches 0 run scoreboard players set #map_failed oa.map2 1
execute unless score #mode oa.map2 matches 1 if score #isle_placed oa.map2 matches 0 run scoreboard players set #map_failed oa.map2 1
execute in oa:br_sky positioned -62 81 103 if block ~ ~ ~ minecraft:redstone_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_3
execute in oa:br_sky positioned -49 84 114 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute in oa:br_sky positioned -43 81 110 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute in oa:br_sky positioned -44 81 101 if block ~ ~ ~ minecraft:redstone_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_3
execute in oa:br_sky positioned -44 81 102 if block ~ ~ ~ minecraft:redstone_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_3
execute in oa:br_sky positioned -45 81 101 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute in oa:br_sky positioned -56 81 90 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest_rich
execute unless score #mode oa.map2 matches 1 in oa:br_sky positioned -56 81 90 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_site
execute in oa:br_sky positioned -51 81 93 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute unless score #mode oa.map2 matches 1 in oa:br_sky positioned -51 81 93 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute in oa:br_sky positioned -52 81 111 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute unless score #mode oa.map2 matches 1 in oa:br_sky positioned -52 81 111 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute in oa:br_sky positioned -58 81 119 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute unless score #mode oa.map2 matches 1 in oa:br_sky positioned -58 81 119 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute in oa:br_sky positioned -58 81 101 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute unless score #mode oa.map2 matches 1 in oa:br_sky positioned -58 81 101 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute in oa:br_sky positioned -68 81 114 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute unless score #mode oa.map2 matches 1 in oa:br_sky positioned -68 81 114 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute in oa:br_sky positioned -44 81 99 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute unless score #mode oa.map2 matches 1 in oa:br_sky positioned -44 81 99 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
data modify storage oa:spawn_points points append value {x:-58.5d,y:81.0d,z:129.5d}
data modify storage oa:spawn_points points append value {x:-41.5d,y:81.0d,z:106.5d}
data modify storage oa:spawn_points points append value {x:-47.5d,y:81.0d,z:120.5d}
data modify storage oa:spawn_points points append value {x:-65.5d,y:81.0d,z:85.5d}
data modify storage oa:spawn_points points append value {x:-30.5d,y:81.0d,z:116.5d}
execute unless score #mode oa.map2 matches 1 in oa:br_sky run summon minecraft:block_display -55.5 96 109.5 {Tags:["oa.isle"],block_state:"minecraft:white_wool",view_range:6.0f,Rotation:[180.0f,0.0f],transformation:{translation:[-4.000f,0.000f,-16.000f],left_rotation:[0.0f,0.0f,0.0f,1.0f],scale:[8.000f,6.000f,32.000f],right_rotation:[0.0f,0.0f,0.0f,1.0f]}}
execute unless score #mode oa.map2 matches 1 in oa:br_sky run summon minecraft:block_display -55.5 96 109.5 {Tags:["oa.isle"],block_state:"minecraft:red_wool",view_range:6.0f,Rotation:[180.0f,0.0f],transformation:{translation:[-4.200f,2.200f,-16.200f],left_rotation:[0.0f,0.0f,0.0f,1.0f],scale:[8.400f,1.200f,32.400f],right_rotation:[0.0f,0.0f,0.0f,1.0f]}}
execute unless score #mode oa.map2 matches 1 in oa:br_sky run summon minecraft:block_display -55.5 81 95.5 {Tags:["oa.isle"],block_state:"minecraft:oak_fence",view_range:6.0f,Rotation:[90.0f,0.0f],transformation:{translation:[-0.075f,0.000f,-0.075f],left_rotation:[0.0f,0.0f,0.0f,1.0f],scale:[0.150f,15.000f,0.150f],right_rotation:[0.0f,0.0f,0.0f,1.0f]}}
execute unless score #mode oa.map2 matches 1 in oa:br_sky run summon minecraft:block_display -55.5 81 109.5 {Tags:["oa.isle"],block_state:"minecraft:oak_fence",view_range:6.0f,Rotation:[90.0f,0.0f],transformation:{translation:[-0.075f,0.000f,-0.075f],left_rotation:[0.0f,0.0f,0.0f,1.0f],scale:[0.150f,15.000f,0.150f],right_rotation:[0.0f,0.0f,0.0f,1.0f]}}
execute unless score #mode oa.map2 matches 1 in oa:br_sky run summon minecraft:block_display -55.5 81 123.5 {Tags:["oa.isle"],block_state:"minecraft:oak_fence",view_range:6.0f,Rotation:[90.0f,0.0f],transformation:{translation:[-0.075f,0.000f,-0.075f],left_rotation:[0.0f,0.0f,0.0f,1.0f],scale:[0.150f,15.000f,0.150f],right_rotation:[0.0f,0.0f,0.0f,1.0f]}}
data modify storage oa:maps layout.sky append value {x:-55,z:109,name:"飛行船の島"}
data modify storage oa:maps sky_region.s3 set value "飛行船の島のあたり"
data modify storage oa:maps sky_isles append value "飛行船の島"
