tellraw @s {"text": "ガイア：霜の襲撃", "color": "aqua"}
function oa:itori/cast_begin
data merge storage oa:damage {amount:2.0,type:"oa:itori_magic"}
execute as @e[tag=oa.target,distance=4.01..] run tag @s remove oa.target
function oa:itori/fx/emit/ice
playsound minecraft:entity.player.attack.sweep player @a[distance=..24] ~ ~ ~ 0.9 0.65
playsound minecraft:block.glass.break player @a[distance=..24] ~ ~ ~ 0.9 0.85
playsound minecraft:entity.breeze.wind_burst player @a[distance=..24] ~ ~ ~ 0.5 1.5
scoreboard players set #i_status oa.tmp 1
function oa:itori/fx/kaeya
scoreboard players set #i_status oa.tmp 0
function oa:itori/cast_end

particle minecraft:snowflake ~ ~1 ~ 0.6 0.7 0.6 0.08 24 normal @a[distance=..28]
playsound minecraft:entity.breeze.wind_burst player @a[distance=..32] ~ ~ ~ 0.8 0.75
