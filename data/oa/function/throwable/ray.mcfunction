execute unless loaded ~ ~ ~ run return 0
execute unless block ~ ~ ~ #oa:push_passable run return 0
# Test swept probe against player feet-relative bounding box in fixed-point units.
execute store result score #probe_x oa.tmp run data get entity @s Pos[0] 10000
execute store result score #probe_y oa.tmp run data get entity @s Pos[1] 10000
execute store result score #probe_z oa.tmp run data get entity @s Pos[2] 10000
execute as @e[tag=oa.target,tag=br.alive,nbt=!{Health:0.0f},distance=..3,sort=nearest] unless score #hit oa.tmp matches 1 run function oa:throwable/body
execute if score #hit oa.tmp matches 1 run return 0
scoreboard players remove #ray oa.tmp 1
execute if score #ray oa.tmp matches 0 run return 0
function oa:throwable/advance with storage oa:throw_step
execute at @s run function oa:throwable/ray
