particle minecraft:happy_villager ~ ~0.5 ~ 1.2 0.4 1.2 0 6 normal @a[distance=..40]
particle minecraft:heart ~ ~1.2 ~ 0.6 0.3 0.6 0 1 normal @a[distance=..40]
execute as @a[tag=br.alive,distance=..3.5] run effect give @s minecraft:regeneration 3 0 true
