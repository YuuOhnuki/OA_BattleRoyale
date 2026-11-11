execute in oa:br run kill @e[distance=0..,type=minecraft:marker,tag=oa.g_move_plan]
scoreboard players set #g_move_ok oa.tmp 1
scoreboard players set #g_count oa.tmp 0
data modify storage oa:g_move args set from storage oa:br center
