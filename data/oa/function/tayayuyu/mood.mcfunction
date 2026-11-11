attribute @s minecraft:movement_speed modifier remove oa:gacha_mood
attribute @s minecraft:movement_speed modifier add oa:gacha_mood 1.0 add_multiplied_total
scoreboard players set @s oa.gmood 100
effect give @s minecraft:blindness 5 0 true
tag @s add oa.gacha_mood
tag @s add oa.gacha_affected
playsound minecraft:entity.warden.heartbeat player @s ~ ~ ~ 1.8 0.7
