tag @e[tag=oa.db_f_target] remove oa.db_f_target
execute as @a[tag=oa.debug] if score @s oa.id = #f_owner oa.tmp at @s run function oa:debug/furo_pool
