tellraw @a[tag=br.playing] {text:"たやゆゆ変態ガチャ：席替えタイム",color:"green"}
tellraw @a[tag=br.playing] {"text": " → 生存者同士の位置をシャッフル", "color": "gray"}
function oa:tayayuyu/move/prepare
execute if score #g_move_ok oa.tmp matches 0 run return run function oa:tayayuyu/move/abort
execute as @a[tag=br.alive,gamemode=!spectator,nbt=!{Health:0.0f},sort=random] at @s run function oa:tayayuyu/move/capture
execute unless score #g_count oa.tmp matches 2.. run return run function oa:tayayuyu/move/abort
execute if score #g_move_ok oa.tmp matches 0 run return run function oa:tayayuyu/move/abort
scoreboard players operation #g_max oa.tmp = #g_count oa.tmp
scoreboard players remove #g_max oa.tmp 1
execute store result storage oa:g_move args.max int 1 run scoreboard players get #g_max oa.tmp
function oa:tayayuyu/move/offset with storage oa:g_move args
function oa:tayayuyu/move/commit
