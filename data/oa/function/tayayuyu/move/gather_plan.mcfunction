scoreboard players set #g_columns oa.tmp 5
scoreboard players set #g_spacing oa.tmp 2
scoreboard players operation #g_x oa.tmp = @s oa.gslot
scoreboard players operation #g_x oa.tmp %= #g_columns oa.tmp
scoreboard players operation #g_x oa.tmp *= #g_spacing oa.tmp
scoreboard players remove #g_x oa.tmp 4
scoreboard players operation #g_z oa.tmp = @s oa.gslot
scoreboard players operation #g_z oa.tmp /= #g_columns oa.tmp
scoreboard players operation #g_z oa.tmp *= #g_spacing oa.tmp
scoreboard players remove #g_z oa.tmp 1
execute store result storage oa:g_move args.dx int 1 run scoreboard players get #g_x oa.tmp
execute store result storage oa:g_move args.dz int 1 run scoreboard players get #g_z oa.tmp
function oa:tayayuyu/move/gather_spread with storage oa:g_move args
