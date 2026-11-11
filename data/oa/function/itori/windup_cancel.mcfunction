execute if entity @s[tag=oa.itori_charge_slow,nbt={active_effects:[{id:"minecraft:slowness",amplifier:3}]}] run effect clear @s minecraft:slowness
tag @s remove oa.itori_charge_slow
tag @s remove oa.itori_windup
scoreboard players set @s oa.i_pending 0
execute store result storage oa:itori id int 1 run scoreboard players get @s oa.id
function oa:itori/windup_remove with storage oa:itori
