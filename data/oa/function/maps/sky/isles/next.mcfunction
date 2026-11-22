# 生成: scripts/build_map_sky.py（直接編集しない）。次の候補地へ（選ばれていなければ飛ばす）
execute if score #isle oa.map2 matches 10.. run return run function oa:maps/sky/isles/finish
execute if score #isle oa.map2 matches 0 if score #sk0 oa.map2 matches -1 run scoreboard players add #isle oa.map2 1
execute if score #isle oa.map2 matches 1 if score #sk1 oa.map2 matches -1 run scoreboard players add #isle oa.map2 1
execute if score #isle oa.map2 matches 2 if score #sk2 oa.map2 matches -1 run scoreboard players add #isle oa.map2 1
execute if score #isle oa.map2 matches 3 if score #sk3 oa.map2 matches -1 run scoreboard players add #isle oa.map2 1
execute if score #isle oa.map2 matches 4 if score #sk4 oa.map2 matches -1 run scoreboard players add #isle oa.map2 1
execute if score #isle oa.map2 matches 5 if score #sk5 oa.map2 matches -1 run scoreboard players add #isle oa.map2 1
execute if score #isle oa.map2 matches 6 if score #sk6 oa.map2 matches -1 run scoreboard players add #isle oa.map2 1
execute if score #isle oa.map2 matches 7 if score #sk7 oa.map2 matches -1 run scoreboard players add #isle oa.map2 1
execute if score #isle oa.map2 matches 8 if score #sk8 oa.map2 matches -1 run scoreboard players add #isle oa.map2 1
execute if score #isle oa.map2 matches 9 if score #sk9 oa.map2 matches -1 run scoreboard players add #isle oa.map2 1
execute if score #isle oa.map2 matches 10.. run return run function oa:maps/sky/isles/finish
execute if score #isle oa.map2 matches 0 run function oa:maps/sky/isles/load_s0
execute if score #isle oa.map2 matches 1 run function oa:maps/sky/isles/load_s1
execute if score #isle oa.map2 matches 2 run function oa:maps/sky/isles/load_s2
execute if score #isle oa.map2 matches 3 run function oa:maps/sky/isles/load_s3
execute if score #isle oa.map2 matches 4 run function oa:maps/sky/isles/load_s4
execute if score #isle oa.map2 matches 5 run function oa:maps/sky/isles/load_s5
execute if score #isle oa.map2 matches 6 run function oa:maps/sky/isles/load_s6
execute if score #isle oa.map2 matches 7 run function oa:maps/sky/isles/load_s7
execute if score #isle oa.map2 matches 8 run function oa:maps/sky/isles/load_s8
execute if score #isle oa.map2 matches 9 run function oa:maps/sky/isles/load_s9
scoreboard players set #isle_wait oa.map2 0
schedule function oa:maps/sky/isles/wait 5t replace
