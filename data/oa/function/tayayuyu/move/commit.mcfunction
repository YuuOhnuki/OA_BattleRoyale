scoreboard players set #g_commit_ok oa.tmp 0
scoreboard players set #g_found oa.tmp 0
execute in oa:br as @e[distance=0..,type=minecraft:marker,tag=oa.g_move_plan] run scoreboard players add #g_found oa.tmp 1
execute unless score #g_found oa.tmp = #g_count oa.tmp run return run function oa:tayayuyu/move/abort
execute as @a[tag=br.alive,gamemode=!spectator,nbt=!{Health:0.0f}] at @s run function oa:tayayuyu/move/player
execute in oa:br run kill @e[distance=0..,type=minecraft:marker,tag=oa.g_move_plan]

scoreboard players set #g_commit_ok oa.tmp 1
