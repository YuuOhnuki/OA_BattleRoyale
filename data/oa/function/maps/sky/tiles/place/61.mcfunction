scoreboard players set #stage oa.map2 1
fill ~-120 ~-40 ~40 ~-89 ~-14 ~71 minecraft:air
fill ~-120 ~-13 ~40 ~-89 ~13 ~71 minecraft:air
fill ~-120 ~14 ~40 ~-89 ~40 ~71 minecraft:air
setblock ~-89 ~-10 ~61 minecraft:stone
setblock ~-89 ~-1 ~61 minecraft:stone
fill ~-89 ~-10 ~66 ~-89 ~-10 ~71 minecraft:stone
fill ~-89 ~-9 ~60 ~-89 ~-9 ~62 minecraft:stone
fill ~-89 ~-9 ~64 ~-89 ~-9 ~71 minecraft:stone
fill ~-89 ~-8 ~59 ~-89 ~-8 ~65 minecraft:stone
fill ~-90 ~-8 ~66 ~-89 ~-8 ~71 minecraft:stone
fill ~-89 ~-7 ~58 ~-89 ~-7 ~62 minecraft:stone
fill ~-90 ~-7 ~63 ~-89 ~-7 ~71 minecraft:stone
fill ~-89 ~-6 ~58 ~-89 ~-6 ~61 minecraft:stone
fill ~-90 ~-6 ~62 ~-89 ~-6 ~71 minecraft:stone
fill ~-89 ~-5 ~57 ~-89 ~-5 ~59 minecraft:stone
fill ~-90 ~-5 ~60 ~-89 ~-5 ~64 minecraft:stone
fill ~-91 ~-5 ~65 ~-89 ~-5 ~71 minecraft:stone
fill ~-89 ~-4 ~57 ~-89 ~-4 ~58 minecraft:stone
fill ~-90 ~-4 ~59 ~-89 ~-4 ~62 minecraft:stone
fill ~-91 ~-4 ~63 ~-89 ~-4 ~71 minecraft:stone
setblock ~-89 ~-3 ~57 minecraft:stone
fill ~-90 ~-3 ~58 ~-89 ~-3 ~60 minecraft:stone
fill ~-91 ~-3 ~61 ~-89 ~-3 ~71 minecraft:stone
fill ~-89 ~-2 ~57 ~-89 ~-1 ~57 minecraft:dirt
fill ~-90 ~-2 ~58 ~-89 ~-2 ~58 minecraft:dirt
setblock ~-90 ~-2 ~59 minecraft:dirt
setblock ~-89 ~-2 ~59 minecraft:stone
fill ~-90 ~-2 ~60 ~-89 ~-2 ~62 minecraft:stone
fill ~-91 ~-2 ~61 ~-91 ~-2 ~62 minecraft:dirt
fill ~-91 ~-2 ~63 ~-89 ~-2 ~66 minecraft:stone
setblock ~-91 ~-2 ~67 minecraft:dirt
fill ~-90 ~-2 ~67 ~-89 ~-2 ~67 minecraft:stone
fill ~-91 ~-2 ~68 ~-89 ~-2 ~71 minecraft:stone
fill ~-90 ~-1 ~58 ~-89 ~-1 ~60 minecraft:dirt
fill ~-91 ~-1 ~61 ~-90 ~-1 ~61 minecraft:dirt
fill ~-91 ~-1 ~62 ~-91 ~-1 ~66 minecraft:dirt
fill ~-90 ~-1 ~62 ~-89 ~-1 ~66 minecraft:stone
fill ~-89 ~-1 ~67 ~-89 ~-1 ~68 minecraft:stone
fill ~-91 ~-1 ~67 ~-90 ~-1 ~68 minecraft:dirt
fill ~-91 ~-1 ~69 ~-91 ~-1 ~71 minecraft:dirt
fill ~-90 ~-1 ~69 ~-89 ~-1 ~71 minecraft:stone
setblock ~-89 ~0 ~57 minecraft:grass_block
fill ~-90 ~0 ~58 ~-89 ~0 ~58 minecraft:grass_block
setblock ~-89 ~0 ~59 minecraft:dirt
setblock ~-90 ~0 ~59 minecraft:grass_block
fill ~-90 ~0 ~60 ~-89 ~0 ~61 minecraft:dirt
fill ~-91 ~0 ~61 ~-91 ~0 ~62 minecraft:grass_block
setblock ~-90 ~0 ~62 minecraft:dirt
fill ~-89 ~0 ~62 ~-89 ~0 ~63 minecraft:stone
fill ~-91 ~0 ~63 ~-90 ~0 ~63 minecraft:dirt
fill ~-91 ~0 ~64 ~-89 ~0 ~66 minecraft:dirt
setblock ~-91 ~0 ~67 minecraft:grass_block
fill ~-90 ~0 ~67 ~-89 ~0 ~67 minecraft:dirt
fill ~-91 ~0 ~68 ~-89 ~0 ~71 minecraft:dirt
setblock ~-89 ~1 ~59 minecraft:grass_block
fill ~-90 ~1 ~60 ~-89 ~1 ~60 minecraft:grass_block
setblock ~-89 ~1 ~61 minecraft:dirt
setblock ~-90 ~1 ~61 minecraft:grass_block
fill ~-90 ~1 ~62 ~-89 ~1 ~66 minecraft:dirt
fill ~-91 ~1 ~63 ~-91 ~1 ~66 minecraft:grass_block
setblock ~-90 ~1 ~67 minecraft:grass_block
fill ~-89 ~1 ~67 ~-89 ~1 ~68 minecraft:dirt
fill ~-91 ~1 ~68 ~-90 ~1 ~68 minecraft:grass_block
fill ~-91 ~1 ~69 ~-91 ~1 ~71 minecraft:grass_block
fill ~-90 ~1 ~69 ~-89 ~1 ~71 minecraft:dirt
setblock ~-89 ~2 ~61 minecraft:grass_block
fill ~-89 ~2 ~62 ~-89 ~2 ~63 minecraft:dirt
fill ~-90 ~2 ~62 ~-90 ~2 ~63 minecraft:grass_block
fill ~-90 ~2 ~64 ~-89 ~2 ~66 minecraft:grass_block
fill ~-89 ~2 ~67 ~-89 ~2 ~68 minecraft:grass_block
fill ~-90 ~2 ~69 ~-89 ~2 ~71 minecraft:grass_block
fill ~-89 ~3 ~62 ~-89 ~3 ~63 minecraft:grass_block
execute if score #sv3 oa.map2 matches 2 run fill ~-91 ~2 ~66 ~-91 ~7 ~66 minecraft:dark_oak_log
execute if score #sv3 oa.map2 matches 2 run fill ~-89 ~3 ~68 ~-89 ~8 ~68 minecraft:dark_oak_log
execute if score #sv3 oa.map2 matches 2 run fill ~-89 ~5 ~69 ~-89 ~6 ~69 minecraft:oak_leaves[persistent=true]
execute if score #sv3 oa.map2 matches 2 run fill ~-90 ~5 ~70 ~-89 ~7 ~71 minecraft:oak_leaves[persistent=true]
execute if score #sv3 oa.map2 matches 2 run fill ~-89 ~6 ~58 ~-89 ~7 ~60 minecraft:oak_leaves[persistent=true]
execute if score #sv3 oa.map2 matches 2 run fill ~-92 ~6 ~64 ~-90 ~7 ~64 minecraft:oak_leaves[persistent=true]
execute if score #sv3 oa.map2 matches 2 run fill ~-93 ~6 ~65 ~-89 ~7 ~65 minecraft:oak_leaves[persistent=true]
execute if score #sv3 oa.map2 matches 2 run fill ~-90 ~6 ~66 ~-89 ~7 ~66 minecraft:oak_leaves[persistent=true]
execute if score #sv3 oa.map2 matches 2 run fill ~-93 ~6 ~66 ~-92 ~7 ~66 minecraft:oak_leaves[persistent=true]
execute if score #sv3 oa.map2 matches 2 run fill ~-93 ~6 ~67 ~-89 ~7 ~67 minecraft:oak_leaves[persistent=true]
execute if score #sv3 oa.map2 matches 2 run fill ~-92 ~6 ~68 ~-90 ~7 ~68 minecraft:oak_leaves[persistent=true]
execute if score #sv3 oa.map2 matches 2 run fill ~-91 ~7 ~69 ~-89 ~8 ~69 minecraft:oak_leaves[persistent=true]
execute if score #sv3 oa.map2 matches 2 run setblock ~-89 ~8 ~59 minecraft:oak_leaves[persistent=true]
execute if score #sv3 oa.map2 matches 2 run setblock ~-91 ~8 ~64 minecraft:oak_leaves[persistent=true]
execute if score #sv3 oa.map2 matches 2 run fill ~-92 ~8 ~65 ~-90 ~8 ~65 minecraft:oak_leaves[persistent=true]
execute if score #sv3 oa.map2 matches 2 run fill ~-93 ~8 ~66 ~-89 ~8 ~66 minecraft:oak_leaves[persistent=true]
execute if score #sv3 oa.map2 matches 2 run fill ~-92 ~8 ~67 ~-89 ~8 ~67 minecraft:oak_leaves[persistent=true]
execute if score #sv3 oa.map2 matches 2 run fill ~-91 ~8 ~68 ~-90 ~8 ~68 minecraft:oak_leaves[persistent=true]
execute if score #sv3 oa.map2 matches 2 run fill ~-90 ~8 ~70 ~-89 ~8 ~70 minecraft:oak_leaves[persistent=true]
execute if score #sv3 oa.map2 matches 2 run setblock ~-89 ~9 ~66 minecraft:oak_leaves[persistent=true]
execute if score #sv3 oa.map2 matches 2 run fill ~-90 ~9 ~67 ~-89 ~9 ~67 minecraft:oak_leaves[persistent=true]
execute if score #sv3 oa.map2 matches 2 run fill ~-91 ~9 ~68 ~-89 ~9 ~68 minecraft:oak_leaves[persistent=true]
execute if score #sv3 oa.map2 matches 2 run fill ~-90 ~9 ~69 ~-89 ~9 ~69 minecraft:oak_leaves[persistent=true]
execute if score #sv3 oa.map2 matches 2 run setblock ~-89 ~9 ~70 minecraft:oak_leaves[persistent=true]
