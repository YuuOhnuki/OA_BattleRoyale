$execute if score #map oa.mapid matches 0 in oa:br at @e[distance=0..,type=minecraft:marker,tag=oa.g_move_plan,scores={oa.gslot=$(slot)},limit=1] run tp @s ~ ~ ~
$execute if score #map oa.mapid matches 1 in oa:br_nether at @e[distance=0..,type=minecraft:marker,tag=oa.g_move_plan,scores={oa.gslot=$(slot)},limit=1] run tp @s ~ ~ ~
