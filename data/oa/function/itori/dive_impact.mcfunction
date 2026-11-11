function oa:itori/cast_begin
execute as @e[tag=oa.target,distance=1.76..] run tag @s remove oa.target
data merge storage oa:damage {amount:5.0,type:"oa:itori_magic"}
execute as @e[tag=oa.target] run function oa:combat/gated_damage
function oa:itori/cast_end
function oa:itori/dive_ring
particle minecraft:explosion ~ ~0.2 ~ 0.6 0.15 0.6 0 3 normal @a[distance=..32]
particle minecraft:electric_spark ~ ~0.2 ~ 1.4 0.25 1.4 0.16 50 normal @a[distance=..32]
particle minecraft:dust{color:[1.0,0.35,0.8],scale:1.5} ~ ~0.15 ~ 1.3 0.2 1.3 0 36 normal @a[distance=..32]
playsound minecraft:entity.generic.explode player @a[distance=..32] ~ ~ ~ 1 1.3
execute store result storage oa:itori id int 1 run scoreboard players get @s oa.id
function oa:itori/dive_remove with storage oa:itori
scoreboard players set @s oa.i_dive 0
attribute @s minecraft:fall_damage_multiplier modifier remove oa:itori_dive
attribute @s minecraft:gravity modifier remove oa:itori_dive
