scoreboard players operation #db_label_owner oa.tmp = @s oa.id
execute as @e[type=minecraft:text_display,tag=oa.debug_damage_label,distance=0..] if score @s oa.owner = #db_label_owner oa.tmp run kill @s
execute store result storage oa:debug_damage amount double 0.001 run scoreboard players get #db_lost br.tmp
function oa:debug/damage_label with storage oa:debug_damage
