execute if data entity @s Item.components."minecraft:custom_name" run data modify entity @s CustomName set from entity @s Item.components."minecraft:custom_name"
data merge entity @s {CustomNameVisible:1b}
tag @s add oa.furo_named
