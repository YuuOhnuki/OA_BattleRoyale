data merge entity @s {Invulnerable:1b,invulnerable:1b}
execute if entity @s[type=minecraft:mannequin] run effect give @s minecraft:resistance infinite 4 true
execute if entity @s[type=minecraft:mannequin] run effect give @s minecraft:fire_resistance infinite 0 true
tag @s add oa.protected1921
