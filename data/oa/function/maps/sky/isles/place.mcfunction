# 生成: scripts/build_map_sky.py（直接編集しない）。今の候補地（#isle）の島を置いて登録する
scoreboard players set #localc oa.map2 0
scoreboard players set #localo oa.map2 0
execute if score #isle oa.map2 matches 0 run function oa:maps/sky/isles/do_s0
execute if score #isle oa.map2 matches 1 run function oa:maps/sky/isles/do_s1
execute if score #isle oa.map2 matches 2 run function oa:maps/sky/isles/do_s2
execute if score #isle oa.map2 matches 3 run function oa:maps/sky/isles/do_s3
execute if score #isle oa.map2 matches 4 run function oa:maps/sky/isles/do_s4
execute if score #isle oa.map2 matches 5 run function oa:maps/sky/isles/do_s5
execute if score #isle oa.map2 matches 6 run function oa:maps/sky/isles/do_s6
execute if score #isle oa.map2 matches 7 run function oa:maps/sky/isles/do_s7
execute if score #isle oa.map2 matches 8 run function oa:maps/sky/isles/do_s8
execute if score #isle oa.map2 matches 9 run function oa:maps/sky/isles/do_s9
scoreboard players operation #chests oa.map2 += #localc oa.map2
scoreboard players operation #ores oa.map2 += #localo oa.map2
