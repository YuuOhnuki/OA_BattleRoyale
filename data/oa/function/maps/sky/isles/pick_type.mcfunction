# 生成: scripts/build_map_sky.py（直接編集しない）
execute store result score #type_roll oa.map2 run random value 1..19
execute if score #type_roll oa.map2 matches 1..1 run scoreboard players set #pt oa.map2 0
execute if score #type_roll oa.map2 matches 2..2 run scoreboard players set #pt oa.map2 1
execute if score #type_roll oa.map2 matches 3..3 run scoreboard players set #pt oa.map2 2
execute if score #type_roll oa.map2 matches 4..4 run scoreboard players set #pt oa.map2 3
execute if score #type_roll oa.map2 matches 5..5 run scoreboard players set #pt oa.map2 4
execute if score #type_roll oa.map2 matches 6..6 run scoreboard players set #pt oa.map2 5
execute if score #type_roll oa.map2 matches 7..7 run scoreboard players set #pt oa.map2 6
execute if score #type_roll oa.map2 matches 8..8 run scoreboard players set #pt oa.map2 7
execute if score #type_roll oa.map2 matches 9..9 run scoreboard players set #pt oa.map2 8
execute if score #type_roll oa.map2 matches 10..10 run scoreboard players set #pt oa.map2 9
execute if score #type_roll oa.map2 matches 11..12 run scoreboard players set #pt oa.map2 10
execute if score #type_roll oa.map2 matches 13..13 run scoreboard players set #pt oa.map2 11
execute if score #type_roll oa.map2 matches 14..14 run scoreboard players set #pt oa.map2 12
execute if score #type_roll oa.map2 matches 15..15 run scoreboard players set #pt oa.map2 13
execute if score #type_roll oa.map2 matches 16..17 run scoreboard players set #pt oa.map2 14
execute if score #type_roll oa.map2 matches 18..18 run scoreboard players set #pt oa.map2 15
execute if score #type_roll oa.map2 matches 19..19 run scoreboard players set #pt oa.map2 16
execute if score #pt oa.map2 matches 0 if score #tu0 oa.map2 matches 1 run return run function oa:maps/sky/isles/pick_type
execute if score #pt oa.map2 matches 1 if score #tu1 oa.map2 matches 1 run return run function oa:maps/sky/isles/pick_type
execute if score #pt oa.map2 matches 2 if score #tu2 oa.map2 matches 1 run return run function oa:maps/sky/isles/pick_type
execute if score #pt oa.map2 matches 3 if score #tu3 oa.map2 matches 1 run return run function oa:maps/sky/isles/pick_type
execute if score #pt oa.map2 matches 4 if score #tu4 oa.map2 matches 1 run return run function oa:maps/sky/isles/pick_type
execute if score #pt oa.map2 matches 5 if score #tu5 oa.map2 matches 1 run return run function oa:maps/sky/isles/pick_type
execute if score #pt oa.map2 matches 6 if score #tu6 oa.map2 matches 1 run return run function oa:maps/sky/isles/pick_type
execute if score #pt oa.map2 matches 7 if score #tu7 oa.map2 matches 1 run return run function oa:maps/sky/isles/pick_type
execute if score #pt oa.map2 matches 8 if score #tu8 oa.map2 matches 1 run return run function oa:maps/sky/isles/pick_type
execute if score #pt oa.map2 matches 9 if score #tu9 oa.map2 matches 1 run return run function oa:maps/sky/isles/pick_type
execute if score #pt oa.map2 matches 10 if score #tu10 oa.map2 matches 1 run return run function oa:maps/sky/isles/pick_type
execute if score #pt oa.map2 matches 11 if score #tu11 oa.map2 matches 1 run return run function oa:maps/sky/isles/pick_type
execute if score #pt oa.map2 matches 12 if score #tu12 oa.map2 matches 1 run return run function oa:maps/sky/isles/pick_type
execute if score #pt oa.map2 matches 13 if score #tu13 oa.map2 matches 1 run return run function oa:maps/sky/isles/pick_type
execute if score #pt oa.map2 matches 14 if score #tu14 oa.map2 matches 1 run return run function oa:maps/sky/isles/pick_type
execute if score #pt oa.map2 matches 15 if score #tu15 oa.map2 matches 1 run return run function oa:maps/sky/isles/pick_type
execute if score #pt oa.map2 matches 16 if score #tu16 oa.map2 matches 1 run return run function oa:maps/sky/isles/pick_type
