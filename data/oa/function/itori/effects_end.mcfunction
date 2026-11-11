attribute @s minecraft:attack_damage modifier remove oa:xilonen_damage
function oa:itori/windup_cancel
execute if entity @s[tag=oa.itori_shield] if data entity @s active_effects[{id:"minecraft:absorption",amplifier:0}] run effect clear @s minecraft:absorption
execute if entity @s[tag=oa.itori_boost] if data entity @s active_effects[{id:"minecraft:speed",amplifier:1}] run effect clear @s minecraft:speed
tag @s remove oa.itori_shield
tag @s remove oa.itori_boost
scoreboard players set @s oa.i_shield 0
scoreboard players set @s oa.i_boost 0
scoreboard players set @s oa.i_leap 0

tag @s remove oa.itori_effect

execute store result storage oa:itori id int 1 run scoreboard players get @s oa.id
function oa:itori/fx/shield_remove with storage oa:itori
scoreboard players set @s oa.i_flins 0
scoreboard players set @s oa.i_dive 0
scoreboard players set @s oa.i_burn 0
function oa:itori/dive_remove with storage oa:itori
attribute @s minecraft:fall_damage_multiplier modifier remove oa:itori_dive
attribute @s minecraft:gravity modifier remove oa:itori_dive
