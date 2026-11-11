function oa:itori/windup_cancel
attribute @s minecraft:attack_damage modifier remove oa:itori_no_melee
execute store result storage oa:itori id int 1 run scoreboard players get @s oa.id
function oa:itori/proxy_remove with storage oa:itori
scoreboard players set @s oa.i_charge 0
