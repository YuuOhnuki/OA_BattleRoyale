execute unless entity @e[tag=oa.yuua_counter_source,distance=..64] run return 0
execute store success score #db_hat_damage oa.tmp run damage @s 10000 oa:execution by @e[tag=oa.yuua_counter_source,distance=..64,limit=1]
execute unless score #db_hat_damage oa.tmp matches 1 run return 0
execute store result score @s oa.db_hp run data get entity @s Health 1000
function oa:debug/damage_infinite
