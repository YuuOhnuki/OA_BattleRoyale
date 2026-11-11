execute unless loaded ~ ~ ~ run return 0
execute unless block ~ ~ ~ #oa:push_passable run return run function oa:furoball/impact_block
execute if block ~ ~ ~ minecraft:water run return run function oa:furoball/explode
data modify storage oa:perf pos set from entity @s Pos
execute store result score #f_probe_x oa.tmp run data get storage oa:perf pos[0] 10000
execute store result score #f_probe_y oa.tmp run data get storage oa:perf pos[1] 10000
execute store result score #f_probe_z oa.tmp run data get storage oa:perf pos[2] 10000
execute unless entity @s[tag=oa.db_projectile] as @a[tag=br.alive,gamemode=!spectator,distance=..6] unless score @s oa.id = #f_owner oa.tmp run function oa:furoball/body
execute if entity @s[tag=oa.db_projectile] run function oa:debug/furo_targets
execute if entity @s[tag=oa.db_projectile] as @e[tag=oa.db_f_target,distance=..6] unless score @s oa.id = #f_owner oa.tmp run function oa:furoball/body
execute if score #f_hit oa.tmp matches 1 run return run function oa:furoball/explode
function oa:furoball/border
execute if score #f_hit oa.tmp matches 1 run return run function oa:furoball/explode
scoreboard players remove #f_step oa.tmp 1
execute if score #f_step oa.tmp matches 0 run return 0
function oa:furoball/move with storage oa:furo_move
execute at @s run function oa:furoball/step
