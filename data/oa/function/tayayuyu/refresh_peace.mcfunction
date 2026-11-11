scoreboard players operation #g_effect_time oa.tmp = @s oa.gpeace
scoreboard players add #g_effect_time oa.tmp 19
scoreboard players set #g_twenty oa.tmp 20
scoreboard players operation #g_effect_time oa.tmp /= #g_twenty oa.tmp
execute store result storage oa:g_effect seconds int 1 run scoreboard players get #g_effect_time oa.tmp
function oa:tayayuyu/effect_peace with storage oa:g_effect
