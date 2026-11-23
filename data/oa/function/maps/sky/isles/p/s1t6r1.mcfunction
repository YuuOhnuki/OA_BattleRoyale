# 生成: scripts/build_map_sky.py（直接編集しない）。候補地 1（86,86）に「飛行船の島」を向き clockwise_90 で置き、登録する（oa:br_sky で）
execute unless score #mode oa.map2 matches 1 in oa:br_sky run function oa:maps/sky/isles/bridge/s1
execute unless score #mode oa.map2 matches 1 in oa:br_sky store success score #isle_placed oa.map2 run place template oa:sky/ship 116 40 56 clockwise_90
execute unless score #mode oa.map2 matches 1 if score #isle_placed oa.map2 matches 0 run tellraw @a[tag=br.admin] {text:"[天空島] 「飛行船の島」を置けませんでした（読み込み）",color:"red"}
execute unless score #mode oa.map2 matches 1 in oa:br_sky store success score #dome_placed oa.map2 run place template oa:sky/dome_s1 56 40 56
execute unless score #mode oa.map2 matches 1 if score #dome_placed oa.map2 matches 0 run scoreboard players set #map_failed oa.map2 1
execute unless score #mode oa.map2 matches 1 if score #isle_placed oa.map2 matches 0 run scoreboard players set #map_failed oa.map2 1
execute in oa:br_sky positioned 79 81 80 if block ~ ~ ~ minecraft:redstone_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_3
execute in oa:br_sky positioned 92 84 91 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute in oa:br_sky positioned 98 81 87 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute in oa:br_sky positioned 97 81 78 if block ~ ~ ~ minecraft:redstone_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_3
execute in oa:br_sky positioned 97 81 79 if block ~ ~ ~ minecraft:redstone_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_3
execute in oa:br_sky positioned 96 81 78 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute in oa:br_sky positioned 85 81 67 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest_rich
execute unless score #mode oa.map2 matches 1 in oa:br_sky positioned 85 81 67 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_site
execute in oa:br_sky positioned 90 81 70 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute unless score #mode oa.map2 matches 1 in oa:br_sky positioned 90 81 70 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute in oa:br_sky positioned 89 81 88 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute unless score #mode oa.map2 matches 1 in oa:br_sky positioned 89 81 88 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute in oa:br_sky positioned 83 81 96 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute unless score #mode oa.map2 matches 1 in oa:br_sky positioned 83 81 96 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute in oa:br_sky positioned 83 81 78 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute unless score #mode oa.map2 matches 1 in oa:br_sky positioned 83 81 78 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute in oa:br_sky positioned 73 81 91 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute unless score #mode oa.map2 matches 1 in oa:br_sky positioned 73 81 91 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute in oa:br_sky positioned 97 81 76 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute unless score #mode oa.map2 matches 1 in oa:br_sky positioned 97 81 76 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
data modify storage oa:spawn_points points append value {x:83.5d,y:81.0d,z:106.5d}
data modify storage oa:spawn_points points append value {x:100.5d,y:81.0d,z:83.5d}
data modify storage oa:spawn_points points append value {x:94.5d,y:81.0d,z:97.5d}
data modify storage oa:spawn_points points append value {x:76.5d,y:81.0d,z:62.5d}
data modify storage oa:spawn_points points append value {x:111.5d,y:81.0d,z:93.5d}
execute unless score #mode oa.map2 matches 1 in oa:br_sky run summon minecraft:block_display 86.5 96 86.5 {Tags:["oa.isle"],block_state:"minecraft:white_wool",view_range:6.0f,Rotation:[180.0f,0.0f],transformation:{translation:[-4.000f,0.000f,-16.000f],left_rotation:[0.0f,0.0f,0.0f,1.0f],scale:[8.000f,6.000f,32.000f],right_rotation:[0.0f,0.0f,0.0f,1.0f]}}
execute unless score #mode oa.map2 matches 1 in oa:br_sky run summon minecraft:block_display 86.5 96 86.5 {Tags:["oa.isle"],block_state:"minecraft:red_wool",view_range:6.0f,Rotation:[180.0f,0.0f],transformation:{translation:[-4.200f,2.200f,-16.200f],left_rotation:[0.0f,0.0f,0.0f,1.0f],scale:[8.400f,1.200f,32.400f],right_rotation:[0.0f,0.0f,0.0f,1.0f]}}
execute unless score #mode oa.map2 matches 1 in oa:br_sky run summon minecraft:block_display 86.5 81 72.5 {Tags:["oa.isle"],block_state:"minecraft:oak_fence",view_range:6.0f,Rotation:[90.0f,0.0f],transformation:{translation:[-0.075f,0.000f,-0.075f],left_rotation:[0.0f,0.0f,0.0f,1.0f],scale:[0.150f,15.000f,0.150f],right_rotation:[0.0f,0.0f,0.0f,1.0f]}}
execute unless score #mode oa.map2 matches 1 in oa:br_sky run summon minecraft:block_display 86.5 81 86.5 {Tags:["oa.isle"],block_state:"minecraft:oak_fence",view_range:6.0f,Rotation:[90.0f,0.0f],transformation:{translation:[-0.075f,0.000f,-0.075f],left_rotation:[0.0f,0.0f,0.0f,1.0f],scale:[0.150f,15.000f,0.150f],right_rotation:[0.0f,0.0f,0.0f,1.0f]}}
execute unless score #mode oa.map2 matches 1 in oa:br_sky run summon minecraft:block_display 86.5 81 100.5 {Tags:["oa.isle"],block_state:"minecraft:oak_fence",view_range:6.0f,Rotation:[90.0f,0.0f],transformation:{translation:[-0.075f,0.000f,-0.075f],left_rotation:[0.0f,0.0f,0.0f,1.0f],scale:[0.150f,15.000f,0.150f],right_rotation:[0.0f,0.0f,0.0f,1.0f]}}
data modify storage oa:maps layout.sky append value {x:86,z:86,name:"飛行船の島"}
data modify storage oa:maps sky_region.s1 set value "飛行船の島のあたり"
data modify storage oa:maps sky_isles append value "飛行船の島"
