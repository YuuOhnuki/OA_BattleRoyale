attribute @s minecraft:gravity modifier remove oa:furo_ascent
tag @s remove oa.furo_ascent
function oa:furoball/stop_lift
attribute @s minecraft:fall_damage_multiplier modifier remove oa:furo_fall
tag @s remove oa.furo_fall
scoreboard players set @s oa.fage 0
scoreboard players set @s oa.fair 0
