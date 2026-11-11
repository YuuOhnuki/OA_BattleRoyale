execute unless loaded ~ ~ ~ run return 0
execute unless block ~ ~ ~ #oa:push_passable run return 0
# Test swept probe against player feet-relative bounding box in fixed-point units.
data modify storage oa:perf pos set from entity @s Pos
execute store result score #probe_x oa.tmp run data get storage oa:perf pos[0] 10000
execute store result score #probe_y oa.tmp run data get storage oa:perf pos[1] 10000
execute store result score #probe_z oa.tmp run data get storage oa:perf pos[2] 10000
execute unless entity @a[tag=oa.observe_owner,tag=oa.debug] as @a[tag=br.alive,tag=!oa.observe_owner,tag=!br.pvp_grace,tag=!oa.self_decoy,tag=!oa.decoy_grace,nbt=!{Health:0.0f},distance=..3,sort=nearest] unless score #hit oa.tmp matches 1 run function oa:throwable/observe/body
execute if entity @a[tag=oa.observe_owner,tag=oa.debug] as @a[tag=oa.debug,tag=!oa.observe_owner,tag=!oa.self_decoy,tag=!oa.decoy_grace,nbt=!{Health:0.0f},distance=..3,sort=nearest] unless score #hit oa.tmp matches 1 run function oa:throwable/observe/body
execute if entity @a[tag=oa.observe_owner,tag=oa.db_mobs] as @e[tag=oa.debug_mob,distance=..3,nbt=!{Health:0.0f},sort=nearest] unless score #hit oa.tmp matches 1 run function oa:throwable/observe/body
execute if score #hit oa.tmp matches 1 run return 0
scoreboard players remove #ray oa.tmp 1
execute if score #ray oa.tmp matches 0 run return 0
function oa:throwable/advance with storage oa:throw_step
execute at @s run function oa:throwable/observe/ray
