execute unless dimension oa:br run return run scoreboard players set #g_move_ok oa.tmp 0
scoreboard players operation @s oa.gslot = #g_count oa.tmp
summon minecraft:marker ~ ~ ~ {Tags:["oa.g_move_plan","oa.g_move_new"]}
scoreboard players operation @e[type=minecraft:marker,tag=oa.g_move_new] oa.gslot = #g_count oa.tmp
scoreboard players add #g_count oa.tmp 1
tag @e[type=minecraft:marker,tag=oa.g_move_new] remove oa.g_move_new
