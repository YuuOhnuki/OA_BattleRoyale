attribute @s minecraft:scale modifier remove oa:gacha_size
tag @s remove oa.gacha_size
execute if score @s oa.kind matches 8 if score @s oa.small matches 1.. run attribute @s minecraft:scale modifier add oa:komame_small -0.5 add_multiplied_total
