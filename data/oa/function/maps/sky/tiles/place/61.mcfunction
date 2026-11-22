scoreboard players set #stage oa.map2 1
fill ~-120 ~-40 ~40 ~-89 ~-14 ~71 minecraft:air
fill ~-120 ~-13 ~40 ~-89 ~13 ~71 minecraft:air
fill ~-120 ~14 ~40 ~-89 ~40 ~71 minecraft:air
fill ~-89 ~-14 ~65 ~-89 ~-14 ~71 minecraft:tuff
fill ~-89 ~-13 ~63 ~-89 ~-13 ~71 minecraft:tuff
fill ~-89 ~-12 ~62 ~-89 ~-12 ~64 minecraft:stone
fill ~-90 ~-12 ~65 ~-89 ~-12 ~71 minecraft:stone
fill ~-89 ~-11 ~60 ~-89 ~-11 ~62 minecraft:stone
fill ~-90 ~-11 ~63 ~-89 ~-11 ~71 minecraft:stone
fill ~-89 ~-10 ~59 ~-89 ~-10 ~60 minecraft:stone
fill ~-90 ~-10 ~61 ~-89 ~-10 ~71 minecraft:stone
fill ~-89 ~-9 ~58 ~-89 ~-9 ~59 minecraft:stone
fill ~-90 ~-9 ~60 ~-89 ~-9 ~63 minecraft:stone
fill ~-91 ~-9 ~64 ~-89 ~-9 ~70 minecraft:stone
fill ~-90 ~-9 ~71 ~-89 ~-9 ~71 minecraft:stone
setblock ~-89 ~-8 ~58 minecraft:stone
fill ~-90 ~-8 ~59 ~-89 ~-8 ~61 minecraft:stone
fill ~-91 ~-8 ~62 ~-89 ~-8 ~71 minecraft:stone
setblock ~-89 ~-7 ~57 minecraft:stone
fill ~-90 ~-7 ~58 ~-89 ~-7 ~60 minecraft:stone
fill ~-91 ~-7 ~61 ~-89 ~-7 ~71 minecraft:stone
fill ~-89 ~-6 ~56 ~-89 ~-6 ~57 minecraft:stone
fill ~-90 ~-6 ~58 ~-89 ~-6 ~59 minecraft:stone
fill ~-91 ~-6 ~60 ~-89 ~-6 ~71 minecraft:stone
setblock ~-89 ~-5 ~56 minecraft:stone
fill ~-90 ~-5 ~57 ~-89 ~-4 ~58 minecraft:stone
fill ~-91 ~-5 ~59 ~-89 ~-5 ~63 minecraft:stone
fill ~-92 ~-5 ~64 ~-89 ~-5 ~66 minecraft:stone
fill ~-91 ~-5 ~67 ~-89 ~-5 ~71 minecraft:stone
fill ~-89 ~-4 ~55 ~-89 ~-4 ~56 minecraft:stone
fill ~-91 ~-4 ~59 ~-89 ~-4 ~62 minecraft:stone
fill ~-92 ~-4 ~63 ~-89 ~-4 ~70 minecraft:stone
fill ~-91 ~-4 ~71 ~-89 ~-3 ~71 minecraft:stone
setblock ~-89 ~-3 ~55 minecraft:stone
fill ~-90 ~-3 ~56 ~-89 ~-3 ~57 minecraft:stone
fill ~-91 ~-3 ~58 ~-89 ~-3 ~61 minecraft:stone
fill ~-92 ~-3 ~62 ~-89 ~-3 ~70 minecraft:stone
fill ~-89 ~-2 ~55 ~-89 ~-1 ~55 minecraft:dirt
fill ~-90 ~-2 ~56 ~-89 ~-1 ~57 minecraft:dirt
fill ~-91 ~-2 ~58 ~-89 ~-1 ~61 minecraft:dirt
fill ~-92 ~-2 ~62 ~-89 ~-1 ~71 minecraft:dirt
setblock ~-89 ~0 ~55 minecraft:grass_block
fill ~-90 ~0 ~56 ~-89 ~0 ~57 minecraft:grass_block
fill ~-91 ~0 ~58 ~-89 ~0 ~61 minecraft:grass_block
fill ~-92 ~0 ~62 ~-89 ~0 ~71 minecraft:grass_block
execute if score #sv3 oa.map2 matches 0 run setblock ~-89 ~1 ~70 minecraft:chest[facing=north]
execute if score #sv3 oa.map2 matches 0 run fill ~-90 ~1 ~70 ~-90 ~1 ~71 minecraft:stone_bricks
execute if score #sv3 oa.map2 matches 0 run setblock ~-90 ~2 ~71 minecraft:mossy_stone_bricks
execute if score #sv3 oa.map2 matches 2 run setblock ~-89 ~1 ~65 minecraft:chest[facing=north]
