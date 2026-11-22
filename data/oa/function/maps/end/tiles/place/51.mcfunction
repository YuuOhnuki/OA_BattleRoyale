scoreboard players set #stage oa.map2 1
fill ~-120 ~-40 ~8 ~-89 ~-14 ~39 minecraft:air
fill ~-120 ~-13 ~8 ~-89 ~13 ~39 minecraft:air
fill ~-120 ~14 ~8 ~-89 ~40 ~39 minecraft:air
fill ~-96 ~-15 ~8 ~-89 ~-15 ~8 minecraft:obsidian
fill ~-98 ~-14 ~8 ~-89 ~-14 ~8 minecraft:obsidian
fill ~-96 ~-14 ~9 ~-89 ~-14 ~9 minecraft:obsidian
fill ~-100 ~-13 ~8 ~-89 ~-13 ~8 minecraft:obsidian
fill ~-98 ~-13 ~9 ~-89 ~-13 ~9 minecraft:obsidian
fill ~-95 ~-13 ~10 ~-89 ~-13 ~10 minecraft:obsidian
fill ~-91 ~-13 ~11 ~-89 ~-13 ~11 minecraft:obsidian
fill ~-101 ~-12 ~8 ~-89 ~-12 ~8 minecraft:obsidian
fill ~-99 ~-12 ~9 ~-89 ~-12 ~9 minecraft:obsidian
fill ~-97 ~-12 ~10 ~-89 ~-12 ~10 minecraft:obsidian
fill ~-95 ~-12 ~11 ~-89 ~-12 ~11 minecraft:obsidian
fill ~-92 ~-12 ~12 ~-90 ~-12 ~12 minecraft:obsidian
fill ~-102 ~-11 ~8 ~-89 ~-11 ~8 minecraft:obsidian
fill ~-100 ~-11 ~9 ~-89 ~-11 ~9 minecraft:obsidian
fill ~-99 ~-11 ~10 ~-89 ~-11 ~10 minecraft:obsidian
fill ~-97 ~-11 ~11 ~-89 ~-11 ~11 minecraft:obsidian
fill ~-94 ~-11 ~12 ~-89 ~-11 ~12 minecraft:obsidian
fill ~-91 ~-11 ~13 ~-90 ~-11 ~13 minecraft:obsidian
fill ~-103 ~-10 ~8 ~-89 ~-10 ~8 minecraft:end_stone
fill ~-101 ~-10 ~9 ~-89 ~-10 ~9 minecraft:end_stone
fill ~-100 ~-10 ~10 ~-89 ~-9 ~10 minecraft:end_stone
fill ~-98 ~-10 ~11 ~-89 ~-9 ~11 minecraft:end_stone
fill ~-96 ~-10 ~12 ~-89 ~-10 ~12 minecraft:end_stone
fill ~-93 ~-10 ~13 ~-89 ~-10 ~13 minecraft:end_stone
setblock ~-91 ~-10 ~14 minecraft:end_stone
fill ~-104 ~-9 ~8 ~-89 ~-7 ~8 minecraft:end_stone
fill ~-102 ~-9 ~9 ~-89 ~-9 ~9 minecraft:end_stone
fill ~-97 ~-9 ~12 ~-89 ~-8 ~12 minecraft:end_stone
fill ~-95 ~-9 ~13 ~-89 ~-8 ~13 minecraft:end_stone
fill ~-92 ~-9 ~14 ~-89 ~-9 ~14 minecraft:end_stone
fill ~-103 ~-8 ~9 ~-89 ~-6 ~9 minecraft:end_stone
fill ~-101 ~-8 ~10 ~-89 ~-7 ~10 minecraft:end_stone
fill ~-99 ~-8 ~11 ~-89 ~-8 ~11 minecraft:end_stone
fill ~-94 ~-8 ~14 ~-89 ~-7 ~14 minecraft:end_stone
fill ~-92 ~-8 ~15 ~-90 ~-8 ~15 minecraft:end_stone
fill ~-100 ~-7 ~11 ~-89 ~-5 ~11 minecraft:end_stone
fill ~-98 ~-7 ~12 ~-89 ~-6 ~12 minecraft:end_stone
fill ~-96 ~-7 ~13 ~-89 ~-7 ~13 minecraft:end_stone
fill ~-92 ~-7 ~15 ~-89 ~-7 ~15 minecraft:end_stone
setblock ~-91 ~-7 ~16 minecraft:end_stone
fill ~-105 ~-6 ~8 ~-89 ~0 ~8 minecraft:end_stone
fill ~-102 ~-6 ~10 ~-89 ~0 ~10 minecraft:end_stone
fill ~-97 ~-6 ~13 ~-89 ~0 ~13 minecraft:end_stone
fill ~-95 ~-6 ~14 ~-89 ~-4 ~14 minecraft:end_stone
fill ~-93 ~-6 ~15 ~-89 ~-6 ~15 minecraft:end_stone
fill ~-92 ~-6 ~16 ~-90 ~-4 ~16 minecraft:end_stone
fill ~-104 ~-5 ~9 ~-89 ~0 ~9 minecraft:end_stone
fill ~-99 ~-5 ~12 ~-89 ~0 ~12 minecraft:end_stone
fill ~-94 ~-5 ~15 ~-89 ~-4 ~15 minecraft:end_stone
fill ~-94 ~-2 ~15 ~-89 ~0 ~15 minecraft:end_stone
fill ~-101 ~-4 ~11 ~-89 ~0 ~11 minecraft:end_stone
setblock ~-89 ~-4 ~16 minecraft:end_stone_bricks
setblock ~-91 ~-4 ~17 minecraft:end_stone
fill ~-91 ~-2 ~17 ~-91 ~0 ~17 minecraft:end_stone
fill ~-96 ~-3 ~14 ~-89 ~0 ~14 minecraft:end_stone
fill ~-94 ~-3 ~15 ~-90 ~-3 ~15 minecraft:end_stone
setblock ~-89 ~-3 ~15 minecraft:end_stone_bricks
fill ~-92 ~-3 ~16 ~-91 ~-3 ~16 minecraft:end_stone
fill ~-90 ~-3 ~16 ~-89 ~-3 ~16 minecraft:end_stone_bricks
setblock ~-91 ~-3 ~17 minecraft:end_stone_bricks
fill ~-93 ~-2 ~16 ~-89 ~0 ~16 minecraft:end_stone
execute if score #sv4 oa.map2 matches 0 run setblock ~-96 ~1 ~10 minecraft:chest[facing=north]
execute if score #sv4 oa.map2 matches 0 run fill ~-98 ~1 ~11 ~-98 ~6 ~11 minecraft:chorus_plant[up=true,down=true]
execute if score #sv4 oa.map2 matches 0 run fill ~-93 ~1 ~12 ~-93 ~6 ~12 minecraft:chorus_plant[up=true,down=true]
execute if score #sv4 oa.map2 matches 0 run setblock ~-97 ~5 ~11 minecraft:chorus_plant[down=true]
execute if score #sv4 oa.map2 matches 0 run setblock ~-99 ~5 ~11 minecraft:chorus_plant[down=true]
execute if score #sv4 oa.map2 matches 0 run setblock ~-94 ~5 ~12 minecraft:chorus_plant[down=true]
execute if score #sv4 oa.map2 matches 0 run setblock ~-92 ~5 ~12 minecraft:chorus_plant[down=true]
execute if score #sv4 oa.map2 matches 0 run setblock ~-98 ~5 ~12 minecraft:chorus_plant[down=true]
execute if score #sv4 oa.map2 matches 0 run setblock ~-93 ~5 ~13 minecraft:chorus_plant[down=true]
execute if score #sv4 oa.map2 matches 0 run setblock ~-99 ~6 ~11 minecraft:chorus_flower[age=5]
execute if score #sv4 oa.map2 matches 0 run setblock ~-97 ~6 ~11 minecraft:chorus_flower[age=5]
execute if score #sv4 oa.map2 matches 0 run setblock ~-94 ~6 ~12 minecraft:chorus_flower[age=5]
execute if score #sv4 oa.map2 matches 0 run setblock ~-92 ~6 ~12 minecraft:chorus_flower[age=5]
execute if score #sv4 oa.map2 matches 0 run setblock ~-98 ~6 ~12 minecraft:chorus_flower[age=5]
execute if score #sv4 oa.map2 matches 0 run setblock ~-93 ~6 ~13 minecraft:chorus_flower[age=5]
execute if score #sv4 oa.map2 matches 0 run setblock ~-98 ~7 ~11 minecraft:chorus_flower[age=5]
execute if score #sv4 oa.map2 matches 0 run setblock ~-93 ~7 ~12 minecraft:chorus_flower[age=5]
execute if score #sv4 oa.map2 matches 2 run setblock ~-98 ~1 ~8 minecraft:purpur_block
execute if score #sv4 oa.map2 matches 2 run setblock ~-99 ~1 ~8 minecraft:end_stone_bricks
execute if score #sv4 oa.map2 matches 2 run setblock ~-99 ~1 ~9 minecraft:purpur_block
execute if score #sv4 oa.map2 matches 2 run setblock ~-98 ~1 ~9 minecraft:end_stone_bricks
execute if score #sv4 oa.map2 matches 2 run fill ~-99 ~1 ~10 ~-98 ~1 ~10 minecraft:end_stone_bricks
execute if score #sv4 oa.map2 matches 2 run setblock ~-98 ~1 ~11 minecraft:purpur_block
execute if score #sv4 oa.map2 matches 2 run setblock ~-99 ~1 ~11 minecraft:end_stone_bricks
execute if score #sv4 oa.map2 matches 2 run setblock ~-98 ~1 ~12 minecraft:end_stone_bricks
execute if score #sv4 oa.map2 matches 2 run setblock ~-99 ~2 ~8 minecraft:purpur_block
execute if score #sv4 oa.map2 matches 2 run fill ~-98 ~2 ~8 ~-98 ~3 ~8 minecraft:end_stone_bricks
execute if score #sv4 oa.map2 matches 2 run fill ~-99 ~2 ~9 ~-98 ~2 ~9 minecraft:end_stone_bricks
execute if score #sv4 oa.map2 matches 2 run setblock ~-98 ~2 ~10 minecraft:purpur_block
execute if score #sv4 oa.map2 matches 2 run setblock ~-99 ~2 ~10 minecraft:end_stone_bricks
execute if score #sv4 oa.map2 matches 2 run setblock ~-99 ~2 ~11 minecraft:purpur_block
execute if score #sv4 oa.map2 matches 2 run fill ~-98 ~2 ~11 ~-98 ~2 ~12 minecraft:end_stone_bricks
execute if score #sv4 oa.map2 matches 2 run setblock ~-98 ~3 ~9 minecraft:purpur_block
execute if score #sv4 oa.map2 matches 2 run setblock ~-99 ~3 ~9 minecraft:end_stone_bricks
execute if score #sv4 oa.map2 matches 2 run setblock ~-99 ~3 ~10 minecraft:purpur_block
