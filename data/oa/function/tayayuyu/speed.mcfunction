attribute @s minecraft:movement_speed modifier remove oa:gacha_speed
attribute @s minecraft:movement_speed modifier add oa:gacha_speed 0.5 add_multiplied_total
scoreboard players set @s oa.gspeed 240

tag @s add oa.gacha_affected

tag @s add oa.gacha_speed
