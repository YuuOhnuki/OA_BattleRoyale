effect give @s minecraft:slowness 3 1 true
tag @s add oa.external_slow
particle minecraft:snowflake ~ ~1 ~ 0.4 0.7 0.4 0.02 24 normal @a[distance=..24]
playsound minecraft:block.glass.hit player @a[distance=..24] ~ ~ ~ 0.8 0.6
