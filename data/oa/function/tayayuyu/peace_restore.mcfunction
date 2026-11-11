scoreboard players operation #g_effect_time oa.tmp = @s oa.gres_left
scoreboard players add #g_effect_time oa.tmp 19
scoreboard players set #g_twenty oa.tmp 20
scoreboard players operation #g_effect_time oa.tmp /= #g_twenty oa.tmp
execute store result storage oa:g_effect seconds int 1 run scoreboard players get #g_effect_time oa.tmp
execute store result storage oa:g_effect amp int 1 run scoreboard players get @s oa.gres_amp
function oa:tayayuyu/peace_restore_apply with storage oa:g_effect
