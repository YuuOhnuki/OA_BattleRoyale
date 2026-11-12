$execute if score #map oa.mapid matches 0 in oa:br positioned $(x) $(y) $(z) run summon minecraft:armor_stand ~ ~ ~ {Tags:["oa.admin_spawn"],Marker:1b,Invisible:1b,NoGravity:1b,Invulnerable:1b}
$execute if score #map oa.mapid matches 1 in oa:br_nether positioned $(x) $(y) $(z) run summon minecraft:armor_stand ~ ~ ~ {Tags:["oa.admin_spawn"],Marker:1b,Invisible:1b,NoGravity:1b,Invulnerable:1b}
scoreboard players set #roster_spawn oa.tmp 0
$execute if score #map oa.mapid matches 0 in oa:br store success score #roster_spawn oa.tmp run spreadplayers $(x) $(z) 0 $(range) false @e[distance=0..,type=minecraft:armor_stand,tag=oa.admin_spawn,limit=1]
$execute if score #map oa.mapid matches 1 in oa:br_nether store success score #roster_spawn oa.tmp run spreadplayers $(x) $(z) 0 $(range) false @e[distance=0..,type=minecraft:armor_stand,tag=oa.admin_spawn,limit=1]
