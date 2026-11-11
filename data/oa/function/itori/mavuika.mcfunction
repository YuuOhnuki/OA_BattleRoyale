tellraw @s {"text": "マーヴィカ：天を焦がす刻", "color": "red"}
summon minecraft:marker ~ ~ ~ {Tags:["oa.itori_sweep","oa.i_new"]}
data modify entity @e[tag=oa.i_new,limit=1] Rotation set from entity @s Rotation
scoreboard players operation @e[tag=oa.i_new,limit=1] oa.owner = @s oa.id
scoreboard players operation @e[tag=oa.i_new,limit=1] br.round = #round br.round
scoreboard players add #serial oa.serial 1
scoreboard players operation @e[tag=oa.i_new,limit=1] oa.i_stamp = #serial oa.serial
scoreboard players set @e[tag=oa.i_new,limit=1] oa.i_frame 0
tag @e[tag=oa.i_new] remove oa.i_new
playsound minecraft:entity.blaze.shoot player @a[distance=..24] ~ ~ ~ 1.0 0.7
function oa:itori/fx/emit/fire_sigil
playsound minecraft:entity.generic.explode player @a[distance=..32] ~ ~ ~ 0.6 0.85

playsound minecraft:entity.ender_dragon.flap player @a[distance=..40] ~ ~ ~ 1.0 0.65
playsound minecraft:item.firecharge.use player @a[distance=..40] ~ ~ ~ 1.0 0.7
playsound minecraft:entity.generic.explode player @a[distance=..40] ~ ~ ~ 0.9 0.6
particle minecraft:flash{color:[1.0,0.45,0.08,1.0]} ~ ~1 ~ 0 0 0 0 1 normal @a[distance=..40]
particle minecraft:flame ~ ~0.8 ~ 1.2 0.7 1.2 0.12 70 normal @a[distance=..40]
particle minecraft:lava ~ ~0.2 ~ 1.5 0.1 1.5 0 16 normal @a[distance=..40]
playsound minecraft:entity.lightning_bolt.thunder player @a[distance=..40] ~ ~ ~ 0.85 1.35
playsound minecraft:entity.ender_dragon.growl player @a[distance=..40] ~ ~ ~ 0.65 1.25
