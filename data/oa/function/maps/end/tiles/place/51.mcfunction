scoreboard players set #stage oa.map2 1
fill ~-120 ~-40 ~8 ~-89 ~-14 ~39 minecraft:air
fill ~-120 ~-13 ~8 ~-89 ~13 ~39 minecraft:air
fill ~-120 ~14 ~8 ~-89 ~40 ~39 minecraft:air
fill ~-98 ~-16 ~8 ~-98 ~-14 ~8 minecraft:obsidian
fill ~-98 ~-13 ~8 ~-97 ~-13 ~8 minecraft:obsidian
fill ~-98 ~-12 ~8 ~-97 ~-10 ~8 minecraft:end_stone
fill ~-98 ~-12 ~9 ~-98 ~-9 ~9 minecraft:end_stone
fill ~-100 ~-9 ~8 ~-93 ~-9 ~8 minecraft:end_stone
fill ~-102 ~-8 ~8 ~-89 ~-8 ~8 minecraft:end_stone
fill ~-99 ~-8 ~9 ~-89 ~-8 ~9 minecraft:end_stone
setblock ~-98 ~-8 ~10 minecraft:end_stone
fill ~-92 ~-8 ~11 ~-92 ~-8 ~12 minecraft:end_stone
fill ~-103 ~-7 ~8 ~-89 ~-7 ~8 minecraft:end_stone
fill ~-101 ~-7 ~9 ~-89 ~-7 ~9 minecraft:end_stone
fill ~-98 ~-7 ~10 ~-89 ~-7 ~10 minecraft:end_stone
fill ~-94 ~-7 ~11 ~-91 ~-7 ~11 minecraft:end_stone
fill ~-92 ~-7 ~12 ~-92 ~-7 ~13 minecraft:end_stone
fill ~-104 ~-6 ~8 ~-89 ~-5 ~8 minecraft:end_stone
fill ~-102 ~-6 ~9 ~-89 ~-6 ~9 minecraft:end_stone
fill ~-99 ~-6 ~10 ~-89 ~-6 ~10 minecraft:end_stone
fill ~-96 ~-6 ~11 ~-89 ~-6 ~11 minecraft:end_stone
setblock ~-98 ~-6 ~11 minecraft:end_stone
fill ~-93 ~-6 ~12 ~-90 ~-6 ~12 minecraft:end_stone
setblock ~-92 ~-6 ~13 minecraft:end_stone
fill ~-103 ~-5 ~9 ~-89 ~-4 ~9 minecraft:end_stone
fill ~-100 ~-5 ~10 ~-89 ~-5 ~10 minecraft:end_stone
fill ~-98 ~-5 ~11 ~-89 ~-5 ~11 minecraft:end_stone
fill ~-95 ~-5 ~12 ~-89 ~-5 ~12 minecraft:end_stone
fill ~-93 ~-5 ~13 ~-90 ~-5 ~13 minecraft:end_stone
setblock ~-91 ~-5 ~14 minecraft:end_stone
fill ~-105 ~-4 ~8 ~-89 ~0 ~8 minecraft:end_stone
fill ~-101 ~-4 ~10 ~-89 ~-4 ~10 minecraft:end_stone
fill ~-99 ~-4 ~11 ~-89 ~0 ~11 minecraft:end_stone
fill ~-96 ~-4 ~12 ~-89 ~-4 ~12 minecraft:end_stone
fill ~-94 ~-4 ~13 ~-89 ~-4 ~13 minecraft:end_stone
fill ~-93 ~-4 ~14 ~-90 ~-4 ~14 minecraft:end_stone
setblock ~-91 ~-4 ~15 minecraft:end_stone
fill ~-104 ~-3 ~9 ~-89 ~0 ~9 minecraft:end_stone
fill ~-102 ~-3 ~10 ~-89 ~0 ~10 minecraft:end_stone
fill ~-97 ~-3 ~12 ~-89 ~0 ~12 minecraft:end_stone
fill ~-95 ~-3 ~13 ~-89 ~0 ~13 minecraft:end_stone
fill ~-93 ~-3 ~14 ~-89 ~0 ~14 minecraft:end_stone
fill ~-92 ~-3 ~15 ~-90 ~0 ~15 minecraft:end_stone
fill ~-91 ~-3 ~16 ~-91 ~0 ~16 minecraft:end_stone
fill ~-89 ~0 ~15 ~-89 ~0 ~16 minecraft:purpur_block
setblock ~-89 ~1 ~8 minecraft:quartz_pillar
fill ~-102 ~1 ~8 ~-99 ~1 ~9 minecraft:end_stone
fill ~-100 ~1 ~10 ~-99 ~1 ~10 minecraft:end_stone
fill ~-89 ~1 ~15 ~-89 ~1 ~16 minecraft:white_stained_glass_pane
setblock ~-89 ~2 ~8 minecraft:end_rod
execute if score #sv4 oa.map2 matches 0 run fill ~-100 ~2 ~10 ~-100 ~7 ~10 minecraft:chorus_plant[up=true,down=true]
execute if score #sv4 oa.map2 matches 0 run setblock ~-100 ~8 ~10 minecraft:chorus_flower[age=5]
