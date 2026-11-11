scoreboard players operation #i_stamp oa.tmp = @s oa.i_stamp
execute as @a[tag=oa.caster,limit=1] run function oa:combat/select_targets
data merge storage oa:damage {amount:6.0,type:"oa:itori_magic"}
execute as @e[tag=oa.target,distance=6.01..] run tag @s remove oa.target
execute store result storage oa:itori frame int 1 run scoreboard players get @s oa.i_frame
scoreboard players set #i_status oa.tmp 2
function oa:itori/sweep_dispatch with storage oa:itori
scoreboard players set #i_status oa.tmp 0
function oa:itori/cast_end
scoreboard players add @s oa.i_frame 1
execute if score @s oa.i_frame matches 24.. run kill @s
execute if score @s oa.i_frame matches 6 run playsound minecraft:entity.player.attack.sweep player @a[distance=..32] ~ ~ ~ 1.0 0.7
execute if score @s oa.i_frame matches 12 run playsound minecraft:item.firecharge.use player @a[distance=..32] ~ ~ ~ 1.0 0.85
execute if score @s oa.i_frame matches 18 run playsound minecraft:entity.player.attack.sweep player @a[distance=..32] ~ ~ ~ 1.0 1.1
execute if score @s oa.i_frame matches 23 run particle minecraft:flame ~ ~0.6 ~ 2 0.4 2 0.08 36 normal @a[distance=..40]
