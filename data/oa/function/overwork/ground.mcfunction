execute if data entity @s Item.components."minecraft:custom_name" run data modify entity @s CustomName set from entity @s Item.components."minecraft:custom_name"
data merge entity @s {CustomNameVisible:1b}
# 固有武器と同じ演出：光の粒の柱と、色付きの粒（ゆーは金色）
particle minecraft:end_rod ~ ~0.8 ~ 0.2 0.4 0.2 0.01 5 normal @a[tag=oa.player,distance=..32]
particle minecraft:end_rod ~ ~1.8 ~ 0.05 0.2 0.05 0 2 normal @a[tag=oa.player,distance=..32]
particle minecraft:dust{color:[1,0.65,0.1],scale:1.8} ~ ~0.5 ~ 0.35 0.15 0.35 0 8 normal @a[tag=oa.player,distance=..32]
