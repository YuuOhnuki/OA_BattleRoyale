# 1.9.180: 目印は、まず会場にいる生存者の位置（チャンクが読み込まれている）に出す。中心のチャンクが読み込まれていないと、
# そこに出した目印が @e で見つからず、途中参加が「安全な配置…に失敗」になる（洞窟で中心に誰もいないと必ず起きた。プラグインの自動テストで発見）。
# 生存者がいなければ、これまでどおり中心に出す。spreadplayers が場所を決めるので、出す位置は結果に影響しない。
execute if score #map oa.mapid matches 0 in oa:br as @a[distance=0..,tag=br.alive,sort=random,limit=1] at @s run summon minecraft:armor_stand ~ ~ ~ {Tags:["oa.admin_spawn"],Marker:1b,Invisible:1b,NoGravity:1b,Invulnerable:1b}
execute if score #map oa.mapid matches 1 in oa:br_nether as @a[distance=0..,tag=br.alive,sort=random,limit=1] at @s run summon minecraft:armor_stand ~ ~ ~ {Tags:["oa.admin_spawn"],Marker:1b,Invisible:1b,NoGravity:1b,Invulnerable:1b}
execute if score #map oa.mapid matches 2 in oa:br_cave as @a[distance=0..,tag=br.alive,sort=random,limit=1] at @s run summon minecraft:armor_stand ~ ~ ~ {Tags:["oa.admin_spawn"],Marker:1b,Invisible:1b,NoGravity:1b,Invulnerable:1b}
$execute if score #map oa.mapid matches 0 in oa:br unless entity @e[distance=0..,type=minecraft:armor_stand,tag=oa.admin_spawn] positioned $(x) $(y) $(z) run summon minecraft:armor_stand ~ ~ ~ {Tags:["oa.admin_spawn"],Marker:1b,Invisible:1b,NoGravity:1b,Invulnerable:1b}
$execute if score #map oa.mapid matches 1 in oa:br_nether unless entity @e[distance=0..,type=minecraft:armor_stand,tag=oa.admin_spawn] positioned $(x) $(y) $(z) run summon minecraft:armor_stand ~ ~ ~ {Tags:["oa.admin_spawn"],Marker:1b,Invisible:1b,NoGravity:1b,Invulnerable:1b}
$execute if score #map oa.mapid matches 2 in oa:br_cave unless entity @e[distance=0..,type=minecraft:armor_stand,tag=oa.admin_spawn] positioned $(x) $(y) $(z) run summon minecraft:armor_stand ~ ~ ~ {Tags:["oa.admin_spawn"],Marker:1b,Invisible:1b,NoGravity:1b,Invulnerable:1b}
scoreboard players set #roster_spawn oa.tmp 0
$execute if score #map oa.mapid matches 0 in oa:br store success score #roster_spawn oa.tmp run spreadplayers $(x) $(z) 0 $(range) false @e[distance=0..,type=minecraft:armor_stand,tag=oa.admin_spawn,limit=1]
$execute if score #map oa.mapid matches 1 in oa:br_nether store success score #roster_spawn oa.tmp run spreadplayers $(x) $(z) 0 $(range) false @e[distance=0..,type=minecraft:armor_stand,tag=oa.admin_spawn,limit=1]
# 1.9.167: 洞窟は天井より下の床を探す（under）。岩の柱の列では奈落に置かれるので、床があるか確かめて最大30回選び直す
execute if score #map oa.mapid matches 2 in oa:br_cave run function oa:admin/players/spawn_cave with storage oa:roster_spawn args
