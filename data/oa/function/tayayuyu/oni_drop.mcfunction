# 1.9.192: 鬼でなくなる（本人として）
tag @s remove oa.g_oni
scoreboard players set @s oa.goni_cd 0
attribute @s minecraft:movement_speed modifier remove oa:gacha_oni
execute unless score #g_oni oa.tmp matches 1.. unless entity @s[tag=oa.gacha_glow] unless entity @s[tag=oa.external_glow] unless entity @s[tag=oa.glow] unless items entity @s armor.head *[minecraft:custom_data~{oa:{kind:1}}] run effect clear @s minecraft:glowing
