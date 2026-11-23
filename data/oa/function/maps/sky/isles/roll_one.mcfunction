# 生成: scripts/build_map_sky.py（直接編集しない）
execute if score #ii oa.map2 >= #in oa.map2 run return 0
function oa:maps/sky/isles/pick_site
function oa:maps/sky/isles/pick_type
execute if score #ps oa.map2 matches 0 run scoreboard players operation #sk0 oa.map2 = #pt oa.map2
execute if score #ps oa.map2 matches 1 run scoreboard players operation #sk1 oa.map2 = #pt oa.map2
execute if score #ps oa.map2 matches 2 run scoreboard players operation #sk2 oa.map2 = #pt oa.map2
execute if score #ps oa.map2 matches 3 run scoreboard players operation #sk3 oa.map2 = #pt oa.map2
execute if score #ps oa.map2 matches 4 run scoreboard players operation #sk4 oa.map2 = #pt oa.map2
execute if score #ps oa.map2 matches 5 run scoreboard players operation #sk5 oa.map2 = #pt oa.map2
execute if score #ps oa.map2 matches 6 run scoreboard players operation #sk6 oa.map2 = #pt oa.map2
execute if score #ps oa.map2 matches 7 run scoreboard players operation #sk7 oa.map2 = #pt oa.map2
execute if score #ps oa.map2 matches 8 run scoreboard players operation #sk8 oa.map2 = #pt oa.map2
execute if score #ps oa.map2 matches 9 run scoreboard players operation #sk9 oa.map2 = #pt oa.map2
execute if score #ps oa.map2 matches 0 store result score #sr0 oa.map2 run random value 0..3
execute if score #ps oa.map2 matches 1 store result score #sr1 oa.map2 run random value 0..3
execute if score #ps oa.map2 matches 2 store result score #sr2 oa.map2 run random value 0..3
execute if score #ps oa.map2 matches 3 store result score #sr3 oa.map2 run random value 0..3
execute if score #ps oa.map2 matches 4 store result score #sr4 oa.map2 run random value 0..3
execute if score #ps oa.map2 matches 5 store result score #sr5 oa.map2 run random value 0..3
execute if score #ps oa.map2 matches 6 store result score #sr6 oa.map2 run random value 0..3
execute if score #ps oa.map2 matches 7 store result score #sr7 oa.map2 run random value 0..3
execute if score #ps oa.map2 matches 8 store result score #sr8 oa.map2 run random value 0..3
execute if score #ps oa.map2 matches 9 store result score #sr9 oa.map2 run random value 0..3
execute if score #pt oa.map2 matches 0 run scoreboard players set #tu0 oa.map2 1
execute if score #pt oa.map2 matches 1 run scoreboard players set #tu1 oa.map2 1
execute if score #pt oa.map2 matches 2 run scoreboard players set #tu2 oa.map2 1
execute if score #pt oa.map2 matches 3 run scoreboard players set #tu3 oa.map2 1
execute if score #pt oa.map2 matches 4 run scoreboard players set #tu4 oa.map2 1
execute if score #pt oa.map2 matches 5 run scoreboard players set #tu5 oa.map2 1
execute if score #pt oa.map2 matches 6 run scoreboard players set #tu6 oa.map2 1
execute if score #pt oa.map2 matches 7 run scoreboard players set #tu7 oa.map2 1
execute if score #pt oa.map2 matches 8 run scoreboard players set #tu8 oa.map2 1
execute if score #pt oa.map2 matches 9 run scoreboard players set #tu9 oa.map2 1
execute if score #pt oa.map2 matches 10 run scoreboard players set #tu10 oa.map2 1
execute if score #pt oa.map2 matches 11 run scoreboard players set #tu11 oa.map2 1
execute if score #pt oa.map2 matches 12 run scoreboard players set #tu12 oa.map2 1
execute if score #pt oa.map2 matches 13 run scoreboard players set #tu13 oa.map2 1
execute if score #pt oa.map2 matches 14 run scoreboard players set #tu14 oa.map2 1
execute if score #pt oa.map2 matches 15 run scoreboard players set #tu15 oa.map2 1
execute if score #pt oa.map2 matches 16 run scoreboard players set #tu16 oa.map2 1
scoreboard players add #ii oa.map2 1
function oa:maps/sky/isles/roll_one
