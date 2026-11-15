execute if entity @s[tag=br.pick_rearm] if block ~ ~-0.1 ~ #oa:br_team_wool run return 0
tag @s remove br.pick_rearm
# 1.9.186: 参加していない人（参加しない印のある人）が羊毛に乗ったら、参加してから選ぶ
execute unless entity @s[tag=br.lobby] if score #state br.state matches 0 run function oa:br/join
execute if block ~ ~-0.1 ~ minecraft:pink_wool run function oa:br/team/1
execute if block ~ ~-0.1 ~ minecraft:cyan_wool run function oa:br/team/2
execute if block ~ ~-0.1 ~ minecraft:red_wool run function oa:br/team/3
execute if block ~ ~-0.1 ~ minecraft:blue_wool run function oa:br/team/4
execute if block ~ ~-0.1 ~ minecraft:lime_wool run function oa:br/team/5
execute if block ~ ~-0.1 ~ minecraft:yellow_wool run function oa:br/team/6
execute if block ~ ~-0.1 ~ minecraft:purple_wool run function oa:br/team/7
execute if block ~ ~-0.1 ~ minecraft:orange_wool run function oa:br/team/8
execute if block ~ ~-0.1 ~ minecraft:white_wool run function oa:br/team/9
execute if block ~ ~-0.1 ~ minecraft:black_wool run function oa:br/team/10
