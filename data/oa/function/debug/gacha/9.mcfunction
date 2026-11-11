# Snapshot everyone first, then cycle through the fixed positions.
data modify storage oa:db_shuffle positions set value []
data modify storage oa:db_shuffle args set value {}
execute as @e[tag=oa.target] run data modify storage oa:db_shuffle positions append from entity @s Pos
execute as @e[tag=oa.target] at @s run function oa:debug/gacha/shuffle_one
