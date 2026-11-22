# 生成: scripts/build_map_sky.py（直接編集しない）。読み込みを待つ（最大30秒）
scoreboard players add #isle_wait oa.map2 1
scoreboard players set #isle_ok oa.map2 0
execute if score #isle oa.map2 matches 0 store result score #isle_ok oa.map2 run function oa:maps/sky/isles/ready_s0
execute if score #isle oa.map2 matches 1 store result score #isle_ok oa.map2 run function oa:maps/sky/isles/ready_s1
execute if score #isle oa.map2 matches 2 store result score #isle_ok oa.map2 run function oa:maps/sky/isles/ready_s2
execute if score #isle oa.map2 matches 3 store result score #isle_ok oa.map2 run function oa:maps/sky/isles/ready_s3
execute if score #isle oa.map2 matches 4 store result score #isle_ok oa.map2 run function oa:maps/sky/isles/ready_s4
execute if score #isle oa.map2 matches 5 store result score #isle_ok oa.map2 run function oa:maps/sky/isles/ready_s5
execute if score #isle oa.map2 matches 6 store result score #isle_ok oa.map2 run function oa:maps/sky/isles/ready_s6
execute if score #isle oa.map2 matches 7 store result score #isle_ok oa.map2 run function oa:maps/sky/isles/ready_s7
execute if score #isle oa.map2 matches 8 store result score #isle_ok oa.map2 run function oa:maps/sky/isles/ready_s8
execute if score #isle oa.map2 matches 9 store result score #isle_ok oa.map2 run function oa:maps/sky/isles/ready_s9
execute if score #isle_ok oa.map2 matches 0 if score #isle_wait oa.map2 matches ..120 run return run schedule function oa:maps/sky/isles/wait 5t replace
execute if score #isle_ok oa.map2 matches 0 run tellraw @a[tag=br.admin] {text:"[天空都市] 島の場所が読み込めなかったので飛ばしました",color:"red"}
execute if score #isle_ok oa.map2 matches 1 run function oa:maps/sky/isles/place
execute if score #isle oa.map2 matches 0 run function oa:maps/sky/isles/unload_s0
execute if score #isle oa.map2 matches 1 run function oa:maps/sky/isles/unload_s1
execute if score #isle oa.map2 matches 2 run function oa:maps/sky/isles/unload_s2
execute if score #isle oa.map2 matches 3 run function oa:maps/sky/isles/unload_s3
execute if score #isle oa.map2 matches 4 run function oa:maps/sky/isles/unload_s4
execute if score #isle oa.map2 matches 5 run function oa:maps/sky/isles/unload_s5
execute if score #isle oa.map2 matches 6 run function oa:maps/sky/isles/unload_s6
execute if score #isle oa.map2 matches 7 run function oa:maps/sky/isles/unload_s7
execute if score #isle oa.map2 matches 8 run function oa:maps/sky/isles/unload_s8
execute if score #isle oa.map2 matches 9 run function oa:maps/sky/isles/unload_s9
scoreboard players add #isle oa.map2 1
schedule function oa:maps/sky/isles/next 2t replace
