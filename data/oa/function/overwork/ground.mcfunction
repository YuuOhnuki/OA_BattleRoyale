execute if data entity @s Item.components."minecraft:custom_name" run data modify entity @s CustomName set from entity @s Item.components."minecraft:custom_name"
data merge entity @s {CustomNameVisible:1b}
execute if entity @a[distance=..24] run particle minecraft:smoke ~ ~0.4 ~ 0.15 0.2 0.15 0.01 3 normal @a[distance=..24]
execute if entity @a[distance=..24] run particle minecraft:wax_on ~ ~0.5 ~ 0.25 0.2 0.25 0 3 normal @a[distance=..24]
