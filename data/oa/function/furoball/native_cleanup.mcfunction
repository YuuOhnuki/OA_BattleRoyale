execute as @a[tag=oa.furo_guard] run attribute @s minecraft:explosion_knockback_resistance modifier remove oa:furo_guard
tag @a remove oa.furo_guard
item replace entity @s weapon.mainhand with minecraft:air
kill @s
