data modify storage oa:damage_hit amount set from storage oa:damage amount
data modify storage oa:damage_hit type set from storage oa:damage type
execute if score @s oa.i_boost matches 1.. store result storage oa:damage_hit amount double 0.001 run data get storage oa:damage amount 1500
scoreboard players set #oa_damage_applied oa.tmp 0
tag @s add oa.routed_damage
function oa:combat/damage_macro with storage oa:damage_hit
tag @s remove oa.routed_damage
execute if score #oa_damage_applied oa.tmp matches 1 if score @s oa.i_flins matches 1.. as @e[tag=oa.damage_target,tag=oa.i_bolt_target,limit=1] at @s run function oa:itori/zap
