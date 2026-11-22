# 生成: scripts/build_map_sky.py（直接編集しない）
execute store result score #pt oa.map2 run random value 0..9
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
