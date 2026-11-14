$execute if score #map oa.mapid matches 0 in oa:br positioned $(x) $(y) $(z) run summon minecraft:armor_stand ~ ~ ~ {Tags:["oa.admin_spawn"],Marker:1b,Invisible:1b,NoGravity:1b,Invulnerable:1b}
$execute if score #map oa.mapid matches 1 in oa:br_nether positioned $(x) $(y) $(z) run summon minecraft:armor_stand ~ ~ ~ {Tags:["oa.admin_spawn"],Marker:1b,Invisible:1b,NoGravity:1b,Invulnerable:1b}
$execute if score #map oa.mapid matches 2 in oa:br_cave positioned $(x) $(y) $(z) run summon minecraft:armor_stand ~ ~ ~ {Tags:["oa.admin_spawn"],Marker:1b,Invisible:1b,NoGravity:1b,Invulnerable:1b}
scoreboard players set #roster_spawn oa.tmp 0
$execute if score #map oa.mapid matches 0 in oa:br store success score #roster_spawn oa.tmp run spreadplayers $(x) $(z) 0 $(range) false @e[distance=0..,type=minecraft:armor_stand,tag=oa.admin_spawn,limit=1]
$execute if score #map oa.mapid matches 1 in oa:br_nether store success score #roster_spawn oa.tmp run spreadplayers $(x) $(z) 0 $(range) false @e[distance=0..,type=minecraft:armor_stand,tag=oa.admin_spawn,limit=1]
# 1.9.167: 洞窟は天井より下の床を探す（under）。岩の柱の列では奈落に置かれるので、床があるか確かめて最大30回選び直す
execute if score #map oa.mapid matches 2 in oa:br_cave run function oa:admin/players/spawn_cave with storage oa:roster_spawn args
