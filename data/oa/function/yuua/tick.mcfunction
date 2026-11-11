effect give @s minecraft:glowing 2 0 true
tag @s add oa.glow
execute if score #clock oa.beat matches 1 run particle minecraft:cherry_leaves ~ ~1.7 ~ 0.35 0.2 0.35 0.02 4 normal @a[distance=..32]
execute if score #clock oa.beat matches 1 run particle minecraft:heart ~ ~2.1 ~ 0.25 0.15 0.25 0 1 normal @a[distance=..32]
