particle minecraft:end_rod ~ ~0.8 ~ 0.2 0.4 0.2 0.01 5 normal @a[tag=oa.player,distance=..32]
particle minecraft:end_rod ~ ~1.8 ~ 0.05 0.2 0.05 0 2 normal @a[tag=oa.player,distance=..32]
execute if data entity @s Item.components."minecraft:custom_data".oa{kind:1} run particle minecraft:dust{"color":[1,0.2,0.6],"scale":1.8} ~ ~0.5 ~ 0.35 0.15 0.35 0 8 normal @a[tag=oa.player,distance=..32]
execute if data entity @s Item.components."minecraft:custom_data".oa{kind:2} run particle minecraft:dust{"color":[0.1,0.5,1],"scale":1.8} ~ ~0.5 ~ 0.35 0.15 0.35 0 8 normal @a[tag=oa.player,distance=..32]
execute if data entity @s Item.components."minecraft:custom_data".oa{kind:3} run particle minecraft:dust{"color":[1,0.8,0.1],"scale":1.8} ~ ~0.5 ~ 0.35 0.15 0.35 0 8 normal @a[tag=oa.player,distance=..32]
execute if data entity @s Item.components."minecraft:custom_data".oa{kind:4} run particle minecraft:dust{"color":[0.4,0.2,0.8],"scale":1.8} ~ ~0.5 ~ 0.35 0.15 0.35 0 8 normal @a[tag=oa.player,distance=..32]
execute if data entity @s Item.components."minecraft:custom_data".oa{kind:5} run particle minecraft:dust{"color":[0.7,0.1,1],"scale":1.8} ~ ~0.5 ~ 0.35 0.15 0.35 0 8 normal @a[tag=oa.player,distance=..32]
execute if data entity @s Item.components."minecraft:custom_data".oa{kind:6} run particle minecraft:dust{"color":[0.1,1,1],"scale":1.8} ~ ~0.5 ~ 0.35 0.15 0.35 0 8 normal @a[tag=oa.player,distance=..32]

execute if data entity @s Item.components."minecraft:custom_data".oa{kind:7} run particle minecraft:dust{"color":[1,0.25,0.2],"scale":1.8} ~ ~0.5 ~ 0.35 0.15 0.35 0 8 normal @a[tag=oa.player,distance=..32]
execute if data entity @s Item.components."minecraft:custom_data".oa{kind:8} run particle minecraft:dust{color:[0.7,0.42,0.48],scale:1.8} ~ ~0.5 ~ 0.35 0.15 0.35 0 8 normal @a[tag=oa.player,distance=..32]

execute if data entity @s Item.components."minecraft:custom_data".oa{kind:9} run particle minecraft:dust{color:[0.25,0.95,0.25],scale:1.7} ~ ~0.5 ~ 0.35 0.2 0.35 0 8 normal @a[tag=oa.player,distance=..32]
