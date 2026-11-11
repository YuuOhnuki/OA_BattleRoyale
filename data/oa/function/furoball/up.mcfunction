function oa:furoball/stop_lift
scoreboard players set @s oa.fage 0
scoreboard players set @s oa.fair 0
tag @s add oa.furo_fall
attribute @s minecraft:fall_damage_multiplier modifier remove oa:furo_fall
attribute @s minecraft:fall_damage_multiplier modifier add oa:furo_fall -1 add_multiplied_total
# Ascending-only gravity adjustment; radial impulse and horizontal momentum unchanged.
attribute @s minecraft:gravity modifier remove oa:furo_ascent
attribute @s minecraft:gravity modifier add oa:furo_ascent 0.45 add_multiplied_total
tag @s add oa.furo_ascent
