tellraw @a[tag=br.playing] {text:"たやゆゆ変態ガチャ：強制集合",color:"green"}
tellraw @a[tag=br.playing] {"text": " → 全員を中央付近へ集合・1秒保護", "color": "gray"}
function oa:tayayuyu/move/prepare
execute if score #g_move_ok oa.tmp matches 0 run return run function oa:tayayuyu/move/abort
execute as @a[tag=br.alive,gamemode=!spectator,nbt=!{Health:0.0f},sort=random] at @s run function oa:tayayuyu/move/capture
execute if score #g_move_ok oa.tmp matches 0 run return run function oa:tayayuyu/move/abort
execute unless score #g_count oa.tmp matches 1.. run return run function oa:tayayuyu/move/abort
execute if score #map oa.mapid matches 0 in oa:br as @e[distance=0..,type=minecraft:marker,tag=oa.g_move_plan] run function oa:tayayuyu/move/gather_plan
execute if score #map oa.mapid matches 1 in oa:br_nether as @e[distance=0..,type=minecraft:marker,tag=oa.g_move_plan] run function oa:tayayuyu/move/gather_plan
execute if score #g_move_ok oa.tmp matches 0 run return run function oa:tayayuyu/move/abort
scoreboard players set #g_offset oa.tmp 0
function oa:tayayuyu/move/commit
execute unless score #g_commit_ok oa.tmp matches 1 run return 0
execute as @a[tag=br.alive,gamemode=!spectator,nbt=!{Health:0.0f}] at @s run function oa:tayayuyu/peace {seconds:1,ticks:20}
