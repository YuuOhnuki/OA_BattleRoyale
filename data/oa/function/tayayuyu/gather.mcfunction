tellraw @a[tag=br.playing] {text:"たやゆゆ変態ガチャ：強制集合",color:"#12a88f"}
tellraw @a[tag=br.playing] {"text": " → 全員が中央へ集合", "color": "gray"}
function oa:tayayuyu/move/prepare
execute if score #g_move_ok oa.tmp matches 0 run return run function oa:tayayuyu/move/abort
execute as @a[tag=br.alive,gamemode=!spectator,tag=!oa.dead,sort=random] at @s run function oa:tayayuyu/move/capture
execute if score #g_move_ok oa.tmp matches 0 run return run function oa:tayayuyu/move/abort
execute unless score #g_count oa.tmp matches 1.. run return run function oa:tayayuyu/move/abort
execute if score #map oa.mapid matches 0 in oa:br as @e[distance=0..,type=minecraft:marker,tag=oa.g_move_plan] run function oa:tayayuyu/move/gather_plan
execute if score #map oa.mapid matches 1 in oa:br_nether as @e[distance=0..,type=minecraft:marker,tag=oa.g_move_plan] run function oa:tayayuyu/move/gather_plan
execute if score #map oa.mapid matches 2 in oa:br_cave as @e[distance=0..,type=minecraft:marker,tag=oa.g_move_plan] run function oa:tayayuyu/move/gather_plan
execute if score #map oa.mapid matches 3 in oa:br_sky as @e[distance=0..,type=minecraft:marker,tag=oa.g_move_plan] run function oa:tayayuyu/move/gather_plan
execute if score #map oa.mapid matches 4 in oa:br_end as @e[distance=0..,type=minecraft:marker,tag=oa.g_move_plan] run function oa:tayayuyu/move/gather_plan
execute if score #g_move_ok oa.tmp matches 0 run return run function oa:tayayuyu/move/abort
scoreboard players set #g_offset oa.tmp 0
function oa:tayayuyu/move/commit
execute unless score #g_commit_ok oa.tmp matches 1 run return 0
execute as @a[tag=br.alive,gamemode=!spectator,tag=!oa.dead] at @s run function oa:tayayuyu/peace {seconds:3,ticks:60}
