# 生成: scripts/build_map_sky.py（直接編集しない）。候補地 2（17,109）に「気球の島」を向き 180 で置き、登録する（oa:br_sky で）
execute unless score #mode oa.map2 matches 1 in oa:br_sky run function oa:maps/sky/isles/bridge/s2
execute unless score #mode oa.map2 matches 1 in oa:br_sky store success score #isle_placed oa.map2 run place template oa:sky/balloon 47 40 139 180
execute unless score #mode oa.map2 matches 1 if score #isle_placed oa.map2 matches 0 run tellraw @a[tag=br.admin] {text:"[天空島] 「気球の島」を置けませんでした（読み込み）",color:"red"}
execute unless score #mode oa.map2 matches 1 in oa:br_sky run place template oa:sky/dome_s2 -13 40 79
execute in oa:br_sky positioned 8 82 109 if block ~ ~ ~ minecraft:redstone_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_3
execute in oa:br_sky positioned 17 81 120 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute in oa:br_sky positioned 20 82 112 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest_rich
execute unless score #mode oa.map2 matches 1 in oa:br_sky positioned 20 82 112 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_site
execute in oa:br_sky positioned 14 82 106 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute unless score #mode oa.map2 matches 1 in oa:br_sky positioned 14 82 106 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute in oa:br_sky positioned 19 69 107 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute unless score #mode oa.map2 matches 1 in oa:br_sky positioned 19 69 107 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute in oa:br_sky positioned 24 81 100 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute unless score #mode oa.map2 matches 1 in oa:br_sky positioned 24 81 100 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute in oa:br_sky positioned 17 81 119 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute unless score #mode oa.map2 matches 1 in oa:br_sky positioned 17 81 119 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute in oa:br_sky positioned 23 81 121 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute unless score #mode oa.map2 matches 1 in oa:br_sky positioned 23 81 121 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
data modify storage oa:spawn_points points append value {x:41.5d,y:81.0d,z:111.5d}
data modify storage oa:spawn_points points append value {x:37.5d,y:81.0d,z:105.5d}
data modify storage oa:spawn_points points append value {x:20.5d,y:81.0d,z:125.5d}
data modify storage oa:spawn_points points append value {x:12.5d,y:81.0d,z:125.5d}
execute unless score #mode oa.map2 matches 1 in oa:br_sky run summon minecraft:block_display 17.5 95 109.5 {Tags:["oa.isle"],block_state:"minecraft:pink_wool",view_range:6.0f,Rotation:[180.0f,0.0f],transformation:{translation:[-10.000f,0.000f,-10.000f],left_rotation:[0.0f,0.0f,0.0f,1.0f],scale:[20.000f,10.000f,20.000f],right_rotation:[0.0f,0.0f,0.0f,1.0f]}}
execute unless score #mode oa.map2 matches 1 in oa:br_sky run summon minecraft:block_display 17.5 95 109.5 {Tags:["oa.isle"],block_state:"minecraft:white_wool",view_range:6.0f,Rotation:[180.0f,0.0f],transformation:{translation:[-11.000f,3.000f,-7.000f],left_rotation:[0.0f,0.0f,0.0f,1.0f],scale:[22.000f,4.000f,14.000f],right_rotation:[0.0f,0.0f,0.0f,1.0f]}}
execute unless score #mode oa.map2 matches 1 in oa:br_sky run summon minecraft:block_display 17.5 95 109.5 {Tags:["oa.isle"],block_state:"minecraft:white_wool",view_range:6.0f,Rotation:[180.0f,0.0f],transformation:{translation:[-7.000f,3.000f,-11.000f],left_rotation:[0.0f,0.0f,0.0f,1.0f],scale:[14.000f,4.000f,22.000f],right_rotation:[0.0f,0.0f,0.0f,1.0f]}}
execute unless score #mode oa.map2 matches 1 in oa:br_sky run summon minecraft:block_display 17.5 95 109.5 {Tags:["oa.isle"],block_state:"minecraft:magenta_wool",view_range:6.0f,Rotation:[180.0f,0.0f],transformation:{translation:[-6.000f,10.000f,-6.000f],left_rotation:[0.0f,0.0f,0.0f,1.0f],scale:[12.000f,2.000f,12.000f],right_rotation:[0.0f,0.0f,0.0f,1.0f]}}
execute unless score #mode oa.map2 matches 1 in oa:br_sky run summon minecraft:block_display 24.5 88 116.5 {Tags:["oa.isle"],block_state:"minecraft:oak_fence",view_range:6.0f,Rotation:[180.0f,0.0f],transformation:{translation:[-0.075f,0.000f,-0.075f],left_rotation:[0.0f,0.0f,0.0f,1.0f],scale:[0.150f,7.000f,0.150f],right_rotation:[0.0f,0.0f,0.0f,1.0f]}}
execute unless score #mode oa.map2 matches 1 in oa:br_sky run summon minecraft:block_display 10.5 88 116.5 {Tags:["oa.isle"],block_state:"minecraft:oak_fence",view_range:6.0f,Rotation:[180.0f,0.0f],transformation:{translation:[-0.075f,0.000f,-0.075f],left_rotation:[0.0f,0.0f,0.0f,1.0f],scale:[0.150f,7.000f,0.150f],right_rotation:[0.0f,0.0f,0.0f,1.0f]}}
execute unless score #mode oa.map2 matches 1 in oa:br_sky run summon minecraft:block_display 24.5 88 102.5 {Tags:["oa.isle"],block_state:"minecraft:oak_fence",view_range:6.0f,Rotation:[180.0f,0.0f],transformation:{translation:[-0.075f,0.000f,-0.075f],left_rotation:[0.0f,0.0f,0.0f,1.0f],scale:[0.150f,7.000f,0.150f],right_rotation:[0.0f,0.0f,0.0f,1.0f]}}
execute unless score #mode oa.map2 matches 1 in oa:br_sky run summon minecraft:block_display 10.5 88 102.5 {Tags:["oa.isle"],block_state:"minecraft:oak_fence",view_range:6.0f,Rotation:[180.0f,0.0f],transformation:{translation:[-0.075f,0.000f,-0.075f],left_rotation:[0.0f,0.0f,0.0f,1.0f],scale:[0.150f,7.000f,0.150f],right_rotation:[0.0f,0.0f,0.0f,1.0f]}}
data modify storage oa:maps layout.sky append value {x:17,z:109,name:"気球の島"}
data modify storage oa:maps sky_region.s2 set value "気球の島のあたり"
data modify storage oa:maps sky_isles append value "気球の島"
