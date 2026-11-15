scoreboard players add #cave_try oa.tmp 1
$spreadplayers $(x) $(z) 0 $(range) under 76 false @e[distance=0..,type=minecraft:armor_stand,tag=oa.admin_spawn,limit=1]
# 1.9.180: 高さの判定を、体積の選択（@s[y=45,dy=33]）から座標の値に変えた。マーカーの防具立ては大きさ0で、箱の端（自分の位置から始まる箱）にいると選択に入らず、洞窟の途中参加が毎回「配置に失敗」になっていた（自動テストで発見）
execute store result score #cave_y oa.tmp run data get entity @e[distance=0..,type=minecraft:armor_stand,tag=oa.admin_spawn,limit=1] Pos[1]
execute as @e[distance=0..,type=minecraft:armor_stand,tag=oa.admin_spawn,limit=1] at @s if score #cave_y oa.tmp matches 45..78 unless block ~ ~-1 ~ #minecraft:air if block ~ ~ ~ #oa:spawn_clear if block ~ ~1 ~ #oa:spawn_clear run return run scoreboard players set #roster_spawn oa.tmp 1
execute if score #cave_try oa.tmp matches 30.. run return 0
function oa:admin/players/spawn_cave_try with storage oa:roster_spawn args
