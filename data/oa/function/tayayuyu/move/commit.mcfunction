scoreboard players set #g_commit_ok oa.tmp 0
scoreboard players set #g_found oa.tmp 0
execute if score #map oa.mapid matches 0 in oa:br as @e[distance=0..,type=minecraft:marker,tag=oa.g_move_plan] run scoreboard players add #g_found oa.tmp 1
execute if score #map oa.mapid matches 1 in oa:br_nether as @e[distance=0..,type=minecraft:marker,tag=oa.g_move_plan] run scoreboard players add #g_found oa.tmp 1
execute if score #map oa.mapid matches 2 in oa:br_cave as @e[distance=0..,type=minecraft:marker,tag=oa.g_move_plan] run scoreboard players add #g_found oa.tmp 1
execute if score #map oa.mapid matches 3 in oa:br_sky as @e[distance=0..,type=minecraft:marker,tag=oa.g_move_plan] run scoreboard players add #g_found oa.tmp 1
execute if score #map oa.mapid matches 4 in oa:br_end as @e[distance=0..,type=minecraft:marker,tag=oa.g_move_plan] run scoreboard players add #g_found oa.tmp 1
execute unless score #g_found oa.tmp = #g_count oa.tmp run return run function oa:tayayuyu/move/abort
execute as @a[tag=br.alive,gamemode=!spectator,tag=!oa.dead] at @s run function oa:tayayuyu/move/player
execute if score #map oa.mapid matches 0 in oa:br run kill @e[distance=0..,type=minecraft:marker,tag=oa.g_move_plan]
execute if score #map oa.mapid matches 1 in oa:br_nether run kill @e[distance=0..,type=minecraft:marker,tag=oa.g_move_plan]
execute if score #map oa.mapid matches 2 in oa:br_cave run kill @e[distance=0..,type=minecraft:marker,tag=oa.g_move_plan]
execute if score #map oa.mapid matches 3 in oa:br_sky run kill @e[distance=0..,type=minecraft:marker,tag=oa.g_move_plan]
execute if score #map oa.mapid matches 4 in oa:br_end run kill @e[distance=0..,type=minecraft:marker,tag=oa.g_move_plan]

scoreboard players set #g_commit_ok oa.tmp 1
