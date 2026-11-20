execute unless entity @s[tag=oa.gacha_glow] unless entity @s[tag=oa.external_glow] unless entity @s[tag=oa.glow] unless items entity @s armor.head *[minecraft:custom_data~{oa:{kind:1}}] run effect clear @s minecraft:glowing
tag @s remove oa.goni_glow
