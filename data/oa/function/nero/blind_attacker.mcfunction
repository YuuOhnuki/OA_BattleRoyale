effect give @s minecraft:blindness 3 0 true
tag @s add oa.external_blind
effect give @s minecraft:glowing 5 0 true
tag @s add oa.external_glow

effect give @s minecraft:weakness 3 0 true
tag @s add oa.external_weak

particle minecraft:flash{color:[0.7,0.3,1.0,1.0]} ~ ~1 ~ 0 0 0 0 1 normal @a[distance=..32]
particle minecraft:reverse_portal ~ ~1 ~ 0.6 0.8 0.6 0.1 36 normal @a[distance=..32]
