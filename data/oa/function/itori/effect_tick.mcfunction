execute unless entity @s[tag=br.alive] unless entity @s[tag=oa.db_free_match] run return run function oa:itori/effects_end
execute store result storage oa:itori id int 1 run scoreboard players get @s oa.id
execute if score @s oa.i_shield matches 1.. run function oa:itori/fx/shield_mesh with storage oa:itori
scoreboard players remove @s[scores={oa.i_shield=1..}] oa.i_shield 1
scoreboard players remove @s[scores={oa.i_boost=1..}] oa.i_boost 1
execute if score #clock oa.beat matches 0 if score @s oa.i_shield matches 1.. run function oa:itori/fx/shield
execute if score #clock oa.beat matches 0 if score @s oa.i_boost matches 1.. run function oa:itori/fx/orange
execute if score @s oa.i_shield matches 0 if entity @s[tag=oa.itori_shield] run function oa:itori/fx/shield_remove with storage oa:itori
execute if score @s oa.i_shield matches 0 run tag @s remove oa.itori_shield
execute if score @s oa.i_boost matches 0 if entity @s[tag=oa.itori_boost] run attribute @s minecraft:attack_damage modifier remove oa:xilonen_damage
execute if score @s oa.i_boost matches 0 run tag @s remove oa.itori_boost
execute if score @s oa.i_leap matches 1.. run function oa:itori/leap_tick

execute unless score @s oa.i_shield matches 1.. unless score @s oa.i_boost matches 1.. run tag @s remove oa.itori_effect
