fill ~-49 ~0 ~-49 ~48 ~8 ~-34 minecraft:air replace minecraft:water
fill ~-49 ~0 ~-33 ~48 ~8 ~-18 minecraft:air replace minecraft:water
fill ~-49 ~0 ~-17 ~48 ~8 ~-2 minecraft:air replace minecraft:water
fill ~-49 ~0 ~-1 ~48 ~8 ~14 minecraft:air replace minecraft:water
fill ~-49 ~0 ~15 ~48 ~8 ~30 minecraft:air replace minecraft:water
fill ~-49 ~0 ~31 ~48 ~8 ~46 minecraft:air replace minecraft:water
fill ~-49 ~0 ~47 ~48 ~8 ~48 minecraft:air replace minecraft:water
kill @e[type=minecraft:marker,tag=oa.button_practice,distance=..75]
kill @e[tag=oa.practice_landmark,distance=..75]
# Replace only the garden's reserved build area.
execute as @e[tag=oa.practice_dummy,tag=!oa.practice_quiet,distance=..70] run function oa:practice/dummy_unname
kill @e[tag=oa.practice_dummy,distance=..70]
kill @e[tag=oa.practice_dummy_spawn,distance=..70]
kill @e[tag=oa.practice_showcase,distance=..45]
kill @e[tag=oa.practice_exit,distance=..45]
kill @e[tag=oa.practice_controls,distance=..45]
kill @e[tag=oa.practice_weapon_1,distance=..45]
kill @e[tag=oa.practice_weapon_2,distance=..45]
kill @e[tag=oa.practice_weapon_3,distance=..45]
kill @e[tag=oa.practice_weapon_4,distance=..45]
kill @e[tag=oa.practice_weapon_5,distance=..45]
kill @e[tag=oa.practice_weapon_6,distance=..45]
kill @e[tag=oa.practice_weapon_7,distance=..45]
kill @e[tag=oa.practice_weapon_8,distance=..45]
kill @e[tag=oa.practice_weapon_9,distance=..45]
kill @e[tag=oa.practice_weapon_10,distance=..45]
kill @e[tag=oa.practice_weapon_11,distance=..45]
kill @e[tag=oa.practice_weapon_12,distance=..45]
fill ~-30 ~1 ~-26 ~30 ~4 ~26 minecraft:air
fill ~-30 ~5 ~-26 ~30 ~8 ~26 minecraft:air
fill ~-30 ~9 ~-26 ~30 ~12 ~26 minecraft:air
fill ~-30 ~13 ~-26 ~30 ~16 ~26 minecraft:air
fill ~-30 ~17 ~-26 ~30 ~20 ~26 minecraft:air
fill ~-50 ~-2 ~-50 ~49 ~-1 ~49 minecraft:stone
fill ~-50 ~ ~-50 ~49 ~ ~49 minecraft:grass_block
fill ~-50 ~1 ~-50 ~49 ~2 ~-50 minecraft:mossy_stone_brick_wall
fill ~-50 ~1 ~49 ~49 ~2 ~49 minecraft:mossy_stone_brick_wall
fill ~-50 ~1 ~-49 ~-50 ~2 ~48 minecraft:mossy_stone_brick_wall
fill ~49 ~1 ~-49 ~49 ~2 ~48 minecraft:mossy_stone_brick_wall
fill ~-45 ~ ~-45 ~45 ~ ~-42 minecraft:gravel
fill ~-45 ~ ~42 ~45 ~ ~45 minecraft:gravel
fill ~-45 ~ ~-41 ~-42 ~ ~41 minecraft:gravel
fill ~42 ~ ~-41 ~45 ~ ~41 minecraft:gravel
fill ~-2 ~ ~25 ~2 ~ ~42 minecraft:gravel
fill ~-42 ~ ~-4 ~-28 ~ ~-2 minecraft:gravel
fill ~27 ~ ~-4 ~42 ~ ~-2 minecraft:gravel
fill ~-2 ~ ~-42 ~2 ~ ~-25 minecraft:gravel
fill ~-29 ~-4 ~-25 ~29 ~-2 ~25 minecraft:stone
fill ~-29 ~-1 ~-25 ~29 ~-1 ~25 minecraft:dirt
fill ~-29 ~ ~-25 ~29 ~ ~25 minecraft:grass_block
fill ~-27 ~-1 ~-5 ~-27 ~-1 ~1 minecraft:gravel
fill ~-27 ~-1 ~-3 ~-27 ~-1 ~-1 minecraft:water
fill ~-27 ~-2 ~-3 ~-27 ~-2 ~-1 minecraft:clay
fill ~-26 ~-1 ~-7 ~-26 ~-1 ~3 minecraft:gravel
fill ~-26 ~-1 ~-5 ~-26 ~-1 ~1 minecraft:water
fill ~-26 ~-2 ~-5 ~-26 ~-2 ~1 minecraft:clay
fill ~-25 ~-1 ~-8 ~-25 ~-1 ~4 minecraft:gravel
fill ~-25 ~-1 ~-6 ~-25 ~-1 ~2 minecraft:water
fill ~-25 ~-2 ~-6 ~-25 ~-2 ~2 minecraft:clay
fill ~-24 ~-1 ~-9 ~-24 ~-1 ~5 minecraft:gravel
fill ~-24 ~-1 ~-7 ~-24 ~-1 ~3 minecraft:water
fill ~-24 ~-2 ~-7 ~-24 ~-2 ~3 minecraft:clay
fill ~-23 ~-1 ~-9 ~-23 ~-1 ~5 minecraft:gravel
fill ~-23 ~-1 ~-7 ~-23 ~-1 ~3 minecraft:water
fill ~-23 ~-2 ~-7 ~-23 ~-2 ~3 minecraft:clay
fill ~-22 ~-1 ~-10 ~-22 ~-1 ~6 minecraft:gravel
fill ~-22 ~-1 ~-8 ~-22 ~-1 ~4 minecraft:water
fill ~-22 ~-2 ~-8 ~-22 ~-2 ~4 minecraft:clay
fill ~-21 ~-1 ~-10 ~-21 ~-1 ~6 minecraft:gravel
fill ~-21 ~-1 ~-8 ~-21 ~-1 ~4 minecraft:water
fill ~-21 ~-2 ~-8 ~-21 ~-2 ~4 minecraft:clay
fill ~-20 ~-1 ~-11 ~-20 ~-1 ~7 minecraft:gravel
fill ~-20 ~-1 ~-9 ~-20 ~-1 ~5 minecraft:water
fill ~-20 ~-2 ~-9 ~-20 ~-2 ~5 minecraft:clay
fill ~-19 ~-1 ~-11 ~-19 ~-1 ~7 minecraft:gravel
fill ~-19 ~-1 ~-9 ~-19 ~-1 ~5 minecraft:water
fill ~-19 ~-2 ~-9 ~-19 ~-2 ~5 minecraft:clay
fill ~-18 ~-1 ~-11 ~-18 ~-1 ~7 minecraft:gravel
fill ~-18 ~-1 ~-9 ~-18 ~-1 ~5 minecraft:water
fill ~-18 ~-2 ~-9 ~-18 ~-2 ~5 minecraft:clay
fill ~-17 ~-1 ~-11 ~-17 ~-1 ~7 minecraft:gravel
fill ~-17 ~-1 ~-9 ~-17 ~-1 ~5 minecraft:water
fill ~-17 ~-2 ~-9 ~-17 ~-2 ~5 minecraft:clay
fill ~-16 ~-1 ~-11 ~-16 ~-1 ~7 minecraft:gravel
fill ~-16 ~-1 ~-9 ~-16 ~-1 ~5 minecraft:water
fill ~-16 ~-2 ~-9 ~-16 ~-2 ~5 minecraft:clay
fill ~-15 ~-1 ~-12 ~-15 ~-1 ~8 minecraft:gravel
fill ~-15 ~-1 ~-10 ~-15 ~-1 ~6 minecraft:water
fill ~-15 ~-2 ~-10 ~-15 ~-2 ~6 minecraft:clay
fill ~-14 ~-1 ~-11 ~-14 ~-1 ~7 minecraft:gravel
fill ~-14 ~-1 ~-9 ~-14 ~-1 ~5 minecraft:water
fill ~-14 ~-2 ~-9 ~-14 ~-2 ~5 minecraft:clay
fill ~-13 ~-1 ~-11 ~-13 ~-1 ~7 minecraft:gravel
fill ~-13 ~-1 ~-9 ~-13 ~-1 ~5 minecraft:water
fill ~-13 ~-2 ~-9 ~-13 ~-2 ~5 minecraft:clay
fill ~-12 ~-1 ~-11 ~-12 ~-1 ~7 minecraft:gravel
fill ~-12 ~-1 ~-9 ~-12 ~-1 ~5 minecraft:water
fill ~-12 ~-2 ~-9 ~-12 ~-2 ~5 minecraft:clay
fill ~-11 ~-1 ~-11 ~-11 ~-1 ~7 minecraft:gravel
fill ~-11 ~-1 ~-9 ~-11 ~-1 ~5 minecraft:water
fill ~-11 ~-2 ~-9 ~-11 ~-2 ~5 minecraft:clay
fill ~-10 ~-1 ~-11 ~-10 ~-1 ~7 minecraft:gravel
fill ~-10 ~-1 ~-9 ~-10 ~-1 ~5 minecraft:water
fill ~-10 ~-2 ~-9 ~-10 ~-2 ~5 minecraft:clay
fill ~-9 ~-1 ~-10 ~-9 ~-1 ~6 minecraft:gravel
fill ~-9 ~-1 ~-8 ~-9 ~-1 ~4 minecraft:water
fill ~-9 ~-2 ~-8 ~-9 ~-2 ~4 minecraft:clay
fill ~-8 ~-1 ~-10 ~-8 ~-1 ~6 minecraft:gravel
fill ~-8 ~-1 ~-8 ~-8 ~-1 ~4 minecraft:water
fill ~-8 ~-2 ~-8 ~-8 ~-2 ~4 minecraft:clay
fill ~-7 ~-1 ~-9 ~-7 ~-1 ~5 minecraft:gravel
fill ~-7 ~-1 ~-7 ~-7 ~-1 ~3 minecraft:water
fill ~-7 ~-2 ~-7 ~-7 ~-2 ~3 minecraft:clay
fill ~-6 ~-1 ~-9 ~-6 ~-1 ~5 minecraft:gravel
fill ~-6 ~-1 ~-7 ~-6 ~-1 ~3 minecraft:water
fill ~-6 ~-2 ~-7 ~-6 ~-2 ~3 minecraft:clay
fill ~-5 ~-1 ~-8 ~-5 ~-1 ~4 minecraft:gravel
fill ~-5 ~-1 ~-6 ~-5 ~-1 ~2 minecraft:water
fill ~-5 ~-2 ~-6 ~-5 ~-2 ~2 minecraft:clay
fill ~-4 ~-1 ~-7 ~-4 ~-1 ~3 minecraft:gravel
fill ~-4 ~-1 ~-5 ~-4 ~-1 ~1 minecraft:water
fill ~-4 ~-2 ~-5 ~-4 ~-2 ~1 minecraft:clay
fill ~-3 ~-1 ~-5 ~-3 ~-1 ~1 minecraft:gravel
fill ~-3 ~-1 ~-3 ~-3 ~-1 ~-1 minecraft:water
fill ~-3 ~-2 ~-3 ~-3 ~-2 ~-1 minecraft:clay
fill ~-27 ~ ~-5 ~-27 ~ ~1 minecraft:air
fill ~-27 ~-1 ~-5 ~-27 ~-1 ~1 minecraft:water
fill ~-26 ~ ~-7 ~-26 ~ ~3 minecraft:air
fill ~-26 ~-1 ~-7 ~-26 ~-1 ~3 minecraft:water
fill ~-25 ~ ~-8 ~-25 ~ ~4 minecraft:air
fill ~-25 ~-1 ~-8 ~-25 ~-1 ~4 minecraft:water
fill ~-24 ~ ~-9 ~-24 ~ ~5 minecraft:air
fill ~-24 ~-1 ~-9 ~-24 ~-1 ~5 minecraft:water
fill ~-23 ~ ~-9 ~-23 ~ ~5 minecraft:air
fill ~-23 ~-1 ~-9 ~-23 ~-1 ~5 minecraft:water
fill ~-22 ~ ~-10 ~-22 ~ ~6 minecraft:air
fill ~-22 ~-1 ~-10 ~-22 ~-1 ~6 minecraft:water
fill ~-21 ~ ~-10 ~-21 ~ ~6 minecraft:air
fill ~-21 ~-1 ~-10 ~-21 ~-1 ~6 minecraft:water
fill ~-20 ~ ~-11 ~-20 ~ ~7 minecraft:air
fill ~-20 ~-1 ~-11 ~-20 ~-1 ~7 minecraft:water
fill ~-19 ~ ~-11 ~-19 ~ ~7 minecraft:air
fill ~-19 ~-1 ~-11 ~-19 ~-1 ~7 minecraft:water
fill ~-18 ~ ~-11 ~-18 ~ ~7 minecraft:air
fill ~-18 ~-1 ~-11 ~-18 ~-1 ~7 minecraft:water
fill ~-17 ~ ~-11 ~-17 ~ ~7 minecraft:air
fill ~-17 ~-1 ~-11 ~-17 ~-1 ~7 minecraft:water
fill ~-16 ~ ~-11 ~-16 ~ ~7 minecraft:air
fill ~-16 ~-1 ~-11 ~-16 ~-1 ~7 minecraft:water
fill ~-15 ~ ~-12 ~-15 ~ ~8 minecraft:air
fill ~-15 ~-1 ~-12 ~-15 ~-1 ~8 minecraft:water
fill ~-14 ~ ~-11 ~-14 ~ ~7 minecraft:air
fill ~-14 ~-1 ~-11 ~-14 ~-1 ~7 minecraft:water
fill ~-13 ~ ~-11 ~-13 ~ ~7 minecraft:air
fill ~-13 ~-1 ~-11 ~-13 ~-1 ~7 minecraft:water
fill ~-12 ~ ~-11 ~-12 ~ ~7 minecraft:air
fill ~-12 ~-1 ~-11 ~-12 ~-1 ~7 minecraft:water
fill ~-11 ~ ~-11 ~-11 ~ ~7 minecraft:air
fill ~-11 ~-1 ~-11 ~-11 ~-1 ~7 minecraft:water
fill ~-10 ~ ~-11 ~-10 ~ ~7 minecraft:air
fill ~-10 ~-1 ~-11 ~-10 ~-1 ~7 minecraft:water
fill ~-9 ~ ~-10 ~-9 ~ ~6 minecraft:air
fill ~-9 ~-1 ~-10 ~-9 ~-1 ~6 minecraft:water
fill ~-8 ~ ~-10 ~-8 ~ ~6 minecraft:air
fill ~-8 ~-1 ~-10 ~-8 ~-1 ~6 minecraft:water
fill ~-7 ~ ~-9 ~-7 ~ ~5 minecraft:air
fill ~-7 ~-1 ~-9 ~-7 ~-1 ~5 minecraft:water
fill ~-6 ~ ~-9 ~-6 ~ ~5 minecraft:air
fill ~-6 ~-1 ~-9 ~-6 ~-1 ~5 minecraft:water
fill ~-5 ~ ~-8 ~-5 ~ ~4 minecraft:air
fill ~-5 ~-1 ~-8 ~-5 ~-1 ~4 minecraft:water
fill ~-4 ~ ~-7 ~-4 ~ ~3 minecraft:air
fill ~-4 ~-1 ~-7 ~-4 ~-1 ~3 minecraft:water
fill ~-3 ~ ~-5 ~-3 ~ ~1 minecraft:air
fill ~-3 ~-1 ~-5 ~-3 ~-1 ~1 minecraft:water
fill ~-2 ~ ~-22 ~2 ~ ~22 minecraft:gravel
fill ~-26 ~ ~15 ~26 ~ ~21 minecraft:coarse_dirt
fill ~5 ~ ~-20 ~26 ~ ~12 minecraft:smooth_sandstone
fill ~7 ~ ~-17 ~24 ~ ~9 minecraft:sand
fill ~-5 ~ ~-24 ~5 ~ ~-17 minecraft:dark_oak_planks
fill ~-5 ~1 ~-24 ~5 ~4 ~-24 minecraft:white_terracotta
fill ~-5 ~1 ~-23 ~-5 ~4 ~-18 minecraft:white_terracotta
fill ~5 ~1 ~-23 ~5 ~4 ~-18 minecraft:white_terracotta
fill ~-5 ~1 ~-17 ~-5 ~4 ~-17 minecraft:stripped_dark_oak_log
fill ~5 ~1 ~-17 ~5 ~4 ~-17 minecraft:stripped_dark_oak_log
fill ~-25 ~1 ~-19 ~-25 ~4 ~-19 minecraft:stripped_spruce_log
fill ~-27 ~4 ~-20 ~-23 ~4 ~-18 minecraft:spruce_leaves[persistent=true]
fill ~-26 ~5 ~-21 ~-24 ~5 ~-18 minecraft:spruce_leaves[persistent=true]
setblock ~-25 ~6 ~-19 minecraft:spruce_leaves[persistent=true]
fill ~-19 ~1 ~-16 ~-19 ~4 ~-16 minecraft:stripped_spruce_log
fill ~-21 ~4 ~-17 ~-17 ~4 ~-15 minecraft:spruce_leaves[persistent=true]
fill ~-20 ~5 ~-18 ~-18 ~5 ~-15 minecraft:spruce_leaves[persistent=true]
setblock ~-19 ~6 ~-16 minecraft:spruce_leaves[persistent=true]
fill ~-12 ~1 ~-18 ~-12 ~4 ~-18 minecraft:stripped_spruce_log
fill ~-14 ~4 ~-19 ~-10 ~4 ~-17 minecraft:spruce_leaves[persistent=true]
fill ~-13 ~5 ~-20 ~-11 ~5 ~-17 minecraft:spruce_leaves[persistent=true]
setblock ~-12 ~6 ~-18 minecraft:spruce_leaves[persistent=true]
fill ~-8 ~1 ~9 ~-8 ~4 ~9 minecraft:stripped_spruce_log
fill ~-10 ~4 ~8 ~-6 ~4 ~10 minecraft:spruce_leaves[persistent=true]
fill ~-9 ~5 ~7 ~-7 ~5 ~10 minecraft:spruce_leaves[persistent=true]
setblock ~-8 ~6 ~9 minecraft:spruce_leaves[persistent=true]
fill ~-24 ~1 ~11 ~-24 ~4 ~11 minecraft:stripped_spruce_log
fill ~-26 ~4 ~10 ~-22 ~4 ~12 minecraft:spruce_leaves[persistent=true]
fill ~-25 ~5 ~9 ~-23 ~5 ~12 minecraft:spruce_leaves[persistent=true]
setblock ~-24 ~6 ~11 minecraft:spruce_leaves[persistent=true]
fill ~24 ~1 ~12 ~24 ~4 ~12 minecraft:stripped_spruce_log
fill ~22 ~4 ~11 ~26 ~4 ~13 minecraft:spruce_leaves[persistent=true]
fill ~23 ~5 ~10 ~25 ~5 ~13 minecraft:spruce_leaves[persistent=true]
setblock ~24 ~6 ~12 minecraft:spruce_leaves[persistent=true]
fill ~24 ~1 ~-22 ~24 ~4 ~-22 minecraft:stripped_spruce_log
fill ~22 ~4 ~-23 ~26 ~4 ~-21 minecraft:spruce_leaves[persistent=true]
fill ~23 ~5 ~-24 ~25 ~5 ~-21 minecraft:spruce_leaves[persistent=true]
setblock ~24 ~6 ~-22 minecraft:spruce_leaves[persistent=true]
fill ~16 ~1 ~-22 ~16 ~4 ~-22 minecraft:stripped_spruce_log
fill ~14 ~4 ~-23 ~18 ~4 ~-21 minecraft:spruce_leaves[persistent=true]
fill ~15 ~5 ~-24 ~17 ~5 ~-21 minecraft:spruce_leaves[persistent=true]
setblock ~16 ~6 ~-22 minecraft:spruce_leaves[persistent=true]
fill ~8 ~1 ~12 ~8 ~4 ~12 minecraft:stripped_spruce_log
fill ~6 ~4 ~11 ~10 ~4 ~13 minecraft:spruce_leaves[persistent=true]
fill ~7 ~5 ~10 ~9 ~5 ~13 minecraft:spruce_leaves[persistent=true]
setblock ~8 ~6 ~12 minecraft:spruce_leaves[persistent=true]
fill ~-25 ~1 ~23 ~-25 ~4 ~23 minecraft:stripped_spruce_log
fill ~-27 ~4 ~22 ~-23 ~4 ~24 minecraft:spruce_leaves[persistent=true]
fill ~-26 ~5 ~21 ~-24 ~5 ~24 minecraft:spruce_leaves[persistent=true]
setblock ~-25 ~6 ~23 minecraft:spruce_leaves[persistent=true]
fill ~25 ~1 ~23 ~25 ~4 ~23 minecraft:stripped_spruce_log
fill ~23 ~4 ~22 ~27 ~4 ~24 minecraft:spruce_leaves[persistent=true]
fill ~24 ~5 ~21 ~26 ~5 ~24 minecraft:spruce_leaves[persistent=true]
setblock ~25 ~6 ~23 minecraft:spruce_leaves[persistent=true]
fill ~-24 ~1 ~-13 ~-22 ~1 ~-13 minecraft:azalea_leaves[persistent=true]
setblock ~-23 ~1 ~-14 minecraft:mossy_cobblestone
setblock ~-23 ~2 ~-13 minecraft:azalea_leaves[persistent=true]
fill ~-18 ~1 ~-13 ~-16 ~1 ~-13 minecraft:azalea_leaves[persistent=true]
setblock ~-17 ~1 ~-14 minecraft:mossy_cobblestone
setblock ~-17 ~2 ~-13 minecraft:azalea_leaves[persistent=true]
fill ~-10 ~1 ~-12 ~-8 ~1 ~-12 minecraft:azalea_leaves[persistent=true]
setblock ~-9 ~1 ~-13 minecraft:mossy_cobblestone
setblock ~-9 ~2 ~-12 minecraft:azalea_leaves[persistent=true]
fill ~-27 ~1 ~5 ~-25 ~1 ~5 minecraft:azalea_leaves[persistent=true]
setblock ~-26 ~1 ~4 minecraft:mossy_cobblestone
setblock ~-26 ~2 ~5 minecraft:azalea_leaves[persistent=true]
fill ~-24 ~1 ~8 ~-22 ~1 ~8 minecraft:azalea_leaves[persistent=true]
setblock ~-23 ~1 ~7 minecraft:mossy_cobblestone
setblock ~-23 ~2 ~8 minecraft:azalea_leaves[persistent=true]
fill ~-15 ~1 ~9 ~-13 ~1 ~9 minecraft:azalea_leaves[persistent=true]
setblock ~-14 ~1 ~8 minecraft:mossy_cobblestone
setblock ~-14 ~2 ~9 minecraft:azalea_leaves[persistent=true]
fill ~-10 ~1 ~11 ~-8 ~1 ~11 minecraft:azalea_leaves[persistent=true]
setblock ~-9 ~1 ~10 minecraft:mossy_cobblestone
setblock ~-9 ~2 ~11 minecraft:azalea_leaves[persistent=true]
fill ~-6 ~1 ~-14 ~-4 ~1 ~-14 minecraft:azalea_leaves[persistent=true]
setblock ~-5 ~1 ~-15 minecraft:mossy_cobblestone
setblock ~-5 ~2 ~-14 minecraft:azalea_leaves[persistent=true]
fill ~4 ~1 ~12 ~6 ~1 ~12 minecraft:azalea_leaves[persistent=true]
setblock ~5 ~1 ~11 minecraft:mossy_cobblestone
setblock ~5 ~2 ~12 minecraft:azalea_leaves[persistent=true]
fill ~25 ~1 ~-9 ~27 ~1 ~-9 minecraft:azalea_leaves[persistent=true]
setblock ~26 ~1 ~-10 minecraft:mossy_cobblestone
setblock ~26 ~2 ~-9 minecraft:azalea_leaves[persistent=true]
fill ~22 ~1 ~10 ~24 ~1 ~10 minecraft:azalea_leaves[persistent=true]
setblock ~23 ~1 ~9 minecraft:mossy_cobblestone
setblock ~23 ~2 ~10 minecraft:azalea_leaves[persistent=true]
fill ~5 ~1 ~-13 ~7 ~1 ~-13 minecraft:azalea_leaves[persistent=true]
setblock ~6 ~1 ~-14 minecraft:mossy_cobblestone
setblock ~6 ~2 ~-13 minecraft:azalea_leaves[persistent=true]
setblock ~-5 ~1 ~13 minecraft:mossy_stone_bricks
setblock ~-5 ~2 ~13 minecraft:stone_brick_wall
setblock ~-5 ~3 ~13 minecraft:lantern
setblock ~5 ~1 ~13 minecraft:mossy_stone_bricks
setblock ~5 ~2 ~13 minecraft:stone_brick_wall
setblock ~5 ~3 ~13 minecraft:lantern
setblock ~-4 ~1 ~-14 minecraft:mossy_stone_bricks
setblock ~-4 ~2 ~-14 minecraft:stone_brick_wall
setblock ~-4 ~3 ~-14 minecraft:lantern
setblock ~4 ~1 ~-14 minecraft:mossy_stone_bricks
setblock ~4 ~2 ~-14 minecraft:stone_brick_wall
setblock ~4 ~3 ~-14 minecraft:lantern
setblock ~-26 ~1 ~-1 minecraft:mossy_stone_bricks
setblock ~-26 ~2 ~-1 minecraft:stone_brick_wall
setblock ~-26 ~3 ~-1 minecraft:lantern
setblock ~-4 ~1 ~-1 minecraft:mossy_stone_bricks
setblock ~-4 ~2 ~-1 minecraft:stone_brick_wall
setblock ~-4 ~3 ~-1 minecraft:lantern
setblock ~27 ~1 ~12 minecraft:mossy_stone_bricks
setblock ~27 ~2 ~12 minecraft:stone_brick_wall
setblock ~27 ~3 ~12 minecraft:lantern
setblock ~27 ~1 ~-17 minecraft:mossy_stone_bricks
setblock ~27 ~2 ~-17 minecraft:stone_brick_wall
setblock ~27 ~3 ~-17 minecraft:lantern
fill ~-3 ~1 ~22 ~-3 ~5 ~22 minecraft:red_concrete
fill ~3 ~1 ~22 ~3 ~5 ~22 minecraft:red_concrete
fill ~-5 ~5 ~22 ~5 ~5 ~22 minecraft:red_concrete
fill ~-6 ~6 ~22 ~6 ~6 ~22 minecraft:deepslate_tiles
fill ~-4 ~4 ~22 ~4 ~4 ~22 minecraft:stripped_dark_oak_log[axis=x]
setblock ~0 ~0 ~22 minecraft:polished_blackstone
setblock ~0 ~1 ~22 minecraft:stone_button[face=floor,facing=south]
summon minecraft:marker ~0.5 ~1 ~22.5 {Tags:["oa.physical_button","oa.button_practice"],data:{action:"practice/leave"}}
summon minecraft:text_display 0.5 ~2.23 22.5 {"Tags": ["oa.practice_exit"], "text": {"text": "ロビーへ戻る　［ボタン］", "color": "gold", "bold": true}, "billboard": "center", "shadow": true, "view_range": 0.5}

setblock ~-24 ~1 ~15 minecraft:chiseled_stone_bricks
setblock ~-24 ~1 ~14 minecraft:stone_button[face=wall,facing=north]
summon minecraft:marker ~-23.5 ~1 ~14.5 {Tags:["oa.physical_button","oa.button_practice"],data:{action:"practice/click/weapon_1"}}
setblock ~-25 ~1 ~15 minecraft:stone_button[face=wall,facing=west]
summon minecraft:marker ~-24.5 ~1 ~15.5 {Tags:["oa.physical_button","oa.button_practice"],data:{action:"practice/click/weapon_1"}}
setblock ~-23 ~1 ~15 minecraft:stone_button[face=wall,facing=east]
summon minecraft:marker ~-22.5 ~1 ~15.5 {Tags:["oa.physical_button","oa.button_practice"],data:{action:"practice/click/weapon_1"}}
setblock ~-24 ~1 ~16 minecraft:stone_button[face=wall,facing=south]
summon minecraft:marker ~-23.5 ~1 ~16.5 {Tags:["oa.physical_button","oa.button_practice"],data:{action:"practice/click/weapon_1"}}
summon minecraft:text_display ~-23.5 ~3.5 ~14.5 {"Tags": ["oa.practice_weapon_1"], "text": {"text": "ぴちぴち ［ボタンで試用］", "color": "gold", "bold": true}, "billboard": "center", "shadow": true, "view_range": 0.5}

setblock ~-15 ~1 ~15 minecraft:chiseled_stone_bricks
setblock ~-15 ~1 ~14 minecraft:stone_button[face=wall,facing=north]
summon minecraft:marker ~-14.5 ~1 ~14.5 {Tags:["oa.physical_button","oa.button_practice"],data:{action:"practice/click/weapon_2"}}
setblock ~-16 ~1 ~15 minecraft:stone_button[face=wall,facing=west]
summon minecraft:marker ~-15.5 ~1 ~15.5 {Tags:["oa.physical_button","oa.button_practice"],data:{action:"practice/click/weapon_2"}}
setblock ~-14 ~1 ~15 minecraft:stone_button[face=wall,facing=east]
summon minecraft:marker ~-13.5 ~1 ~15.5 {Tags:["oa.physical_button","oa.button_practice"],data:{action:"practice/click/weapon_2"}}
setblock ~-15 ~1 ~16 minecraft:stone_button[face=wall,facing=south]
summon minecraft:marker ~-14.5 ~1 ~16.5 {Tags:["oa.physical_button","oa.button_practice"],data:{action:"practice/click/weapon_2"}}
summon minecraft:text_display ~-14.5 ~3.5 ~14.5 {"Tags": ["oa.practice_weapon_2"], "text": {"text": "ゆうあ ［ボタンで試用］", "color": "gold", "bold": true}, "billboard": "center", "shadow": true, "view_range": 0.5}

setblock ~-6 ~1 ~15 minecraft:chiseled_stone_bricks
setblock ~-6 ~1 ~14 minecraft:stone_button[face=wall,facing=north]
summon minecraft:marker ~-5.5 ~1 ~14.5 {Tags:["oa.physical_button","oa.button_practice"],data:{action:"practice/click/weapon_3"}}
setblock ~-7 ~1 ~15 minecraft:stone_button[face=wall,facing=west]
summon minecraft:marker ~-6.5 ~1 ~15.5 {Tags:["oa.physical_button","oa.button_practice"],data:{action:"practice/click/weapon_3"}}
setblock ~-5 ~1 ~15 minecraft:stone_button[face=wall,facing=east]
summon minecraft:marker ~-4.5 ~1 ~15.5 {Tags:["oa.physical_button","oa.button_practice"],data:{action:"practice/click/weapon_3"}}
setblock ~-6 ~1 ~16 minecraft:stone_button[face=wall,facing=south]
summon minecraft:marker ~-5.5 ~1 ~16.5 {Tags:["oa.physical_button","oa.button_practice"],data:{action:"practice/click/weapon_3"}}
summon minecraft:text_display ~-5.5 ~3.5 ~14.5 {"Tags": ["oa.practice_weapon_3"], "text": {"text": "ゆったり ［ボタンで試用］", "color": "gold", "bold": true}, "billboard": "center", "shadow": true, "view_range": 0.5}

setblock ~3 ~1 ~15 minecraft:chiseled_stone_bricks
setblock ~3 ~1 ~14 minecraft:stone_button[face=wall,facing=north]
summon minecraft:marker ~3.5 ~1 ~14.5 {Tags:["oa.physical_button","oa.button_practice"],data:{action:"practice/click/weapon_4"}}
setblock ~2 ~1 ~15 minecraft:stone_button[face=wall,facing=west]
summon minecraft:marker ~2.5 ~1 ~15.5 {Tags:["oa.physical_button","oa.button_practice"],data:{action:"practice/click/weapon_4"}}
setblock ~4 ~1 ~15 minecraft:stone_button[face=wall,facing=east]
summon minecraft:marker ~4.5 ~1 ~15.5 {Tags:["oa.physical_button","oa.button_practice"],data:{action:"practice/click/weapon_4"}}
setblock ~3 ~1 ~16 minecraft:stone_button[face=wall,facing=south]
summon minecraft:marker ~3.5 ~1 ~16.5 {Tags:["oa.physical_button","oa.button_practice"],data:{action:"practice/click/weapon_4"}}
summon minecraft:text_display ~3.5 ~3.5 ~14.5 {"Tags": ["oa.practice_weapon_4"], "text": {"text": "キリング ［ボタンで試用］", "color": "gold", "bold": true}, "billboard": "center", "shadow": true, "view_range": 0.5}

setblock ~12 ~1 ~15 minecraft:chiseled_stone_bricks
setblock ~12 ~1 ~14 minecraft:stone_button[face=wall,facing=north]
summon minecraft:marker ~12.5 ~1 ~14.5 {Tags:["oa.physical_button","oa.button_practice"],data:{action:"practice/click/weapon_5"}}
setblock ~11 ~1 ~15 minecraft:stone_button[face=wall,facing=west]
summon minecraft:marker ~11.5 ~1 ~15.5 {Tags:["oa.physical_button","oa.button_practice"],data:{action:"practice/click/weapon_5"}}
setblock ~13 ~1 ~15 minecraft:stone_button[face=wall,facing=east]
summon minecraft:marker ~13.5 ~1 ~15.5 {Tags:["oa.physical_button","oa.button_practice"],data:{action:"practice/click/weapon_5"}}
setblock ~12 ~1 ~16 minecraft:stone_button[face=wall,facing=south]
summon minecraft:marker ~12.5 ~1 ~16.5 {Tags:["oa.physical_button","oa.button_practice"],data:{action:"practice/click/weapon_5"}}
summon minecraft:text_display ~12.5 ~3.5 ~14.5 {"Tags": ["oa.practice_weapon_5"], "text": {"text": "らじ ［ボタンで試用］", "color": "gold", "bold": true}, "billboard": "center", "shadow": true, "view_range": 0.5}

setblock ~21 ~1 ~15 minecraft:chiseled_stone_bricks
setblock ~21 ~1 ~14 minecraft:stone_button[face=wall,facing=north]
summon minecraft:marker ~21.5 ~1 ~14.5 {Tags:["oa.physical_button","oa.button_practice"],data:{action:"practice/click/weapon_6"}}
setblock ~20 ~1 ~15 minecraft:stone_button[face=wall,facing=west]
summon minecraft:marker ~20.5 ~1 ~15.5 {Tags:["oa.physical_button","oa.button_practice"],data:{action:"practice/click/weapon_6"}}
setblock ~22 ~1 ~15 minecraft:stone_button[face=wall,facing=east]
summon minecraft:marker ~22.5 ~1 ~15.5 {Tags:["oa.physical_button","oa.button_practice"],data:{action:"practice/click/weapon_6"}}
setblock ~21 ~1 ~16 minecraft:stone_button[face=wall,facing=south]
summon minecraft:marker ~21.5 ~1 ~16.5 {Tags:["oa.physical_button","oa.button_practice"],data:{action:"practice/click/weapon_6"}}
summon minecraft:text_display ~21.5 ~3.5 ~14.5 {"Tags": ["oa.practice_weapon_6"], "text": {"text": "こまめ ［ボタンで試用］", "color": "gold", "bold": true}, "billboard": "center", "shadow": true, "view_range": 0.5}

setblock ~-24 ~1 ~21 minecraft:chiseled_stone_bricks
setblock ~-24 ~1 ~20 minecraft:stone_button[face=wall,facing=north]
summon minecraft:marker ~-23.5 ~1 ~20.5 {Tags:["oa.physical_button","oa.button_practice"],data:{action:"practice/click/weapon_7"}}
setblock ~-25 ~1 ~21 minecraft:stone_button[face=wall,facing=west]
summon minecraft:marker ~-24.5 ~1 ~21.5 {Tags:["oa.physical_button","oa.button_practice"],data:{action:"practice/click/weapon_7"}}
setblock ~-23 ~1 ~21 minecraft:stone_button[face=wall,facing=east]
summon minecraft:marker ~-22.5 ~1 ~21.5 {Tags:["oa.physical_button","oa.button_practice"],data:{action:"practice/click/weapon_7"}}
setblock ~-24 ~1 ~22 minecraft:stone_button[face=wall,facing=south]
summon minecraft:marker ~-23.5 ~1 ~22.5 {Tags:["oa.physical_button","oa.button_practice"],data:{action:"practice/click/weapon_7"}}
summon minecraft:text_display ~-23.5 ~3.5 ~20.5 {"Tags": ["oa.practice_weapon_7"], "text": {"text": "ねろ ［ボタンで試用］", "color": "gold", "bold": true}, "billboard": "center", "shadow": true, "view_range": 0.5}

setblock ~-15 ~1 ~21 minecraft:chiseled_stone_bricks
setblock ~-15 ~1 ~20 minecraft:stone_button[face=wall,facing=north]
summon minecraft:marker ~-14.5 ~1 ~20.5 {Tags:["oa.physical_button","oa.button_practice"],data:{action:"practice/click/weapon_8"}}
setblock ~-16 ~1 ~21 minecraft:stone_button[face=wall,facing=west]
summon minecraft:marker ~-15.5 ~1 ~21.5 {Tags:["oa.physical_button","oa.button_practice"],data:{action:"practice/click/weapon_8"}}
setblock ~-14 ~1 ~21 minecraft:stone_button[face=wall,facing=east]
summon minecraft:marker ~-13.5 ~1 ~21.5 {Tags:["oa.physical_button","oa.button_practice"],data:{action:"practice/click/weapon_8"}}
setblock ~-15 ~1 ~22 minecraft:stone_button[face=wall,facing=south]
summon minecraft:marker ~-14.5 ~1 ~22.5 {Tags:["oa.physical_button","oa.button_practice"],data:{action:"practice/click/weapon_8"}}
summon minecraft:text_display ~-14.5 ~3.5 ~20.5 {"Tags": ["oa.practice_weapon_8"], "text": {"text": "ゆー ［ボタンで試用］", "color": "gold", "bold": true}, "billboard": "center", "shadow": true, "view_range": 0.5}

setblock ~-6 ~1 ~21 minecraft:chiseled_stone_bricks
setblock ~-6 ~1 ~20 minecraft:stone_button[face=wall,facing=north]
summon minecraft:marker ~-5.5 ~1 ~20.5 {Tags:["oa.physical_button","oa.button_practice"],data:{action:"practice/click/weapon_9"}}
setblock ~-7 ~1 ~21 minecraft:stone_button[face=wall,facing=west]
summon minecraft:marker ~-6.5 ~1 ~21.5 {Tags:["oa.physical_button","oa.button_practice"],data:{action:"practice/click/weapon_9"}}
setblock ~-5 ~1 ~21 minecraft:stone_button[face=wall,facing=east]
summon minecraft:marker ~-4.5 ~1 ~21.5 {Tags:["oa.physical_button","oa.button_practice"],data:{action:"practice/click/weapon_9"}}
setblock ~-6 ~1 ~22 minecraft:stone_button[face=wall,facing=south]
summon minecraft:marker ~-5.5 ~1 ~22.5 {Tags:["oa.physical_button","oa.button_practice"],data:{action:"practice/click/weapon_9"}}
summon minecraft:text_display ~-5.5 ~3.5 ~20.5 {"Tags": ["oa.practice_weapon_9"], "text": {"text": "ほちきす ［ボタンで試用］", "color": "gold", "bold": true}, "billboard": "center", "shadow": true, "view_range": 0.5}

setblock ~3 ~1 ~21 minecraft:chiseled_stone_bricks
setblock ~3 ~1 ~20 minecraft:stone_button[face=wall,facing=north]
summon minecraft:marker ~3.5 ~1 ~20.5 {Tags:["oa.physical_button","oa.button_practice"],data:{action:"practice/click/weapon_10"}}
setblock ~2 ~1 ~21 minecraft:stone_button[face=wall,facing=west]
summon minecraft:marker ~2.5 ~1 ~21.5 {Tags:["oa.physical_button","oa.button_practice"],data:{action:"practice/click/weapon_10"}}
setblock ~4 ~1 ~21 minecraft:stone_button[face=wall,facing=east]
summon minecraft:marker ~4.5 ~1 ~21.5 {Tags:["oa.physical_button","oa.button_practice"],data:{action:"practice/click/weapon_10"}}
setblock ~3 ~1 ~22 minecraft:stone_button[face=wall,facing=south]
summon minecraft:marker ~3.5 ~1 ~22.5 {Tags:["oa.physical_button","oa.button_practice"],data:{action:"practice/click/weapon_10"}}
summon minecraft:text_display ~3.5 ~3.5 ~20.5 {"Tags": ["oa.practice_weapon_10"], "text": {"text": "たやゆゆ ［ボタンで試用］", "color": "gold", "bold": true}, "billboard": "center", "shadow": true, "view_range": 0.5}

setblock ~12 ~1 ~21 minecraft:chiseled_stone_bricks
setblock ~12 ~1 ~20 minecraft:stone_button[face=wall,facing=north]
summon minecraft:marker ~12.5 ~1 ~20.5 {Tags:["oa.physical_button","oa.button_practice"],data:{action:"practice/click/weapon_11"}}
setblock ~11 ~1 ~21 minecraft:stone_button[face=wall,facing=west]
summon minecraft:marker ~11.5 ~1 ~21.5 {Tags:["oa.physical_button","oa.button_practice"],data:{action:"practice/click/weapon_11"}}
setblock ~13 ~1 ~21 minecraft:stone_button[face=wall,facing=east]
summon minecraft:marker ~13.5 ~1 ~21.5 {Tags:["oa.physical_button","oa.button_practice"],data:{action:"practice/click/weapon_11"}}
setblock ~12 ~1 ~22 minecraft:stone_button[face=wall,facing=south]
summon minecraft:marker ~12.5 ~1 ~22.5 {Tags:["oa.physical_button","oa.button_practice"],data:{action:"practice/click/weapon_11"}}
summon minecraft:text_display ~12.5 ~3.5 ~20.5 {"Tags": ["oa.practice_weapon_11"], "text": {"text": "ふろボール ［ボタンで試用］", "color": "gold", "bold": true}, "billboard": "center", "shadow": true, "view_range": 0.5}

setblock ~21 ~1 ~21 minecraft:chiseled_stone_bricks
setblock ~21 ~1 ~20 minecraft:stone_button[face=wall,facing=north]
summon minecraft:marker ~21.5 ~1 ~20.5 {Tags:["oa.physical_button","oa.button_practice"],data:{action:"practice/click/weapon_12"}}
setblock ~20 ~1 ~21 minecraft:stone_button[face=wall,facing=west]
summon minecraft:marker ~20.5 ~1 ~21.5 {Tags:["oa.physical_button","oa.button_practice"],data:{action:"practice/click/weapon_12"}}
setblock ~22 ~1 ~21 minecraft:stone_button[face=wall,facing=east]
summon minecraft:marker ~22.5 ~1 ~21.5 {Tags:["oa.physical_button","oa.button_practice"],data:{action:"practice/click/weapon_12"}}
setblock ~21 ~1 ~22 minecraft:stone_button[face=wall,facing=south]
summon minecraft:marker ~21.5 ~1 ~22.5 {Tags:["oa.physical_button","oa.button_practice"],data:{action:"practice/click/weapon_12"}}
summon minecraft:text_display ~21.5 ~3.5 ~20.5 {"Tags": ["oa.practice_weapon_12"], "text": {"text": "昭心 ［ボタンで試用］", "color": "gold", "bold": true}, "billboard": "center", "shadow": true, "view_range": 0.5}

setblock ~-18 ~ ~-8 minecraft:lily_pad
setblock ~-11 ~ ~-8 minecraft:lily_pad
setblock ~-21 ~ ~2 minecraft:lily_pad
setblock ~-14 ~ ~5 minecraft:lily_pad
fill ~-25 ~ ~-8 ~-24 ~1 ~-7 minecraft:mossy_cobblestone
setblock ~-24 ~2 ~-8 minecraft:andesite_slab
fill ~-6 ~ ~4 ~-5 ~1 ~5 minecraft:cobblestone
setblock ~-6 ~2 ~4 minecraft:mossy_cobblestone_slab
fill ~24 ~1 ~-8 ~25 ~1 ~-7 minecraft:andesite
setblock ~25 ~2 ~-8 minecraft:polished_andesite_slab
setblock ~7 ~1 ~-4 minecraft:mossy_cobblestone_slab
fill ~11 ~ ~11 ~21 ~ ~11 minecraft:chiseled_stone_bricks
fill ~11 ~ ~12 ~21 ~ ~12 minecraft:gravel

fill ~-27 ~ ~-4 ~-2 ~ ~-2 minecraft:stone_bricks
fill ~-28 ~1 ~-4 ~-2 ~1 ~-4 minecraft:stone_brick_wall
fill ~-28 ~1 ~-2 ~-2 ~1 ~-2 minecraft:stone_brick_wall
fill ~-25 ~-2 ~-4 ~-25 ~-1 ~-2 minecraft:mossy_stone_bricks
setblock ~-25 ~2 ~-4 minecraft:lantern
fill ~-20 ~-2 ~-4 ~-20 ~-1 ~-2 minecraft:mossy_stone_bricks
setblock ~-20 ~2 ~-4 minecraft:lantern
fill ~-15 ~-2 ~-4 ~-15 ~-1 ~-2 minecraft:mossy_stone_bricks
setblock ~-15 ~2 ~-4 minecraft:lantern
fill ~-10 ~-2 ~-4 ~-10 ~-1 ~-2 minecraft:mossy_stone_bricks
setblock ~-10 ~2 ~-4 minecraft:lantern
fill ~-5 ~-2 ~-4 ~-5 ~-1 ~-2 minecraft:mossy_stone_bricks
setblock ~-5 ~2 ~-4 minecraft:lantern
fill ~-29 ~ ~-4 ~-28 ~ ~-2 minecraft:gravel
fill ~-2 ~ ~-4 ~2 ~ ~-2 minecraft:gravel
setblock ~-28 ~1 ~-3 minecraft:air
fill ~-2 ~1 ~-4 ~2 ~1 ~-2 minecraft:air
fill ~-24 ~ ~-18 ~-22 ~ ~-16 minecraft:moss_block
setblock ~-23 ~1 ~-17 minecraft:azalea_leaves[persistent=true]
setblock ~-22 ~1 ~-16 minecraft:pink_petals[flower_amount=3]
fill ~-17 ~ ~11 ~-15 ~ ~13 minecraft:moss_block
setblock ~-16 ~1 ~12 minecraft:azalea_leaves[persistent=true]
setblock ~-15 ~1 ~13 minecraft:pink_petals[flower_amount=3]
fill ~-10 ~ ~-19 ~-8 ~ ~-17 minecraft:moss_block
setblock ~-9 ~1 ~-18 minecraft:azalea_leaves[persistent=true]
setblock ~-8 ~1 ~-17 minecraft:pink_petals[flower_amount=3]
fill ~22 ~ ~17 ~24 ~ ~19 minecraft:moss_block
setblock ~23 ~1 ~18 minecraft:azalea_leaves[persistent=true]
setblock ~24 ~1 ~19 minecraft:pink_petals[flower_amount=3]
fill ~11 ~ ~-22 ~13 ~ ~-20 minecraft:moss_block
setblock ~12 ~1 ~-21 minecraft:azalea_leaves[persistent=true]
setblock ~13 ~1 ~-20 minecraft:pink_petals[flower_amount=3]
fill ~-27 ~1 ~-12 ~-26 ~1 ~-11 minecraft:mossy_cobblestone
setblock ~-27 ~2 ~-12 minecraft:andesite_slab
fill ~-13 ~1 ~-13 ~-12 ~1 ~-12 minecraft:mossy_cobblestone
setblock ~-13 ~2 ~-13 minecraft:andesite_slab
fill ~-26 ~1 ~7 ~-25 ~1 ~8 minecraft:mossy_cobblestone
setblock ~-26 ~2 ~7 minecraft:andesite_slab
fill ~-7 ~1 ~7 ~-6 ~1 ~8 minecraft:mossy_cobblestone
setblock ~-7 ~2 ~7 minecraft:andesite_slab
fill ~19 ~1 ~-19 ~20 ~1 ~-18 minecraft:mossy_cobblestone
setblock ~19 ~2 ~-19 minecraft:andesite_slab
fill ~8 ~1 ~7 ~9 ~1 ~8 minecraft:mossy_cobblestone
setblock ~8 ~2 ~7 minecraft:andesite_slab
summon minecraft:item_display ~-23.5 ~2.42 ~15.5 {"Tags":["oa.practice_showcase"],"item":{"id":"minecraft:carrot_on_a_stick","count":1,"components":{"minecraft:item_model":"oa:pichipichi"}},"item_display":"none","billboard":"center","view_range":0.55,"transformation":{"translation":[0.0,0.0,0.0],"left_rotation":[0.0,0.0,0.0,1.0],"scale":[1.0,1.0,1.0],"right_rotation":[0.0,0.0,0.0,1.0]}}
summon minecraft:item_display ~-14.5 ~2.42 ~15.5 {"Tags":["oa.practice_showcase"],"item":{"id":"minecraft:carrot_on_a_stick","count":1,"components":{"minecraft:item_model":"oa:yuua"}},"item_display":"none","billboard":"center","view_range":0.55,"transformation":{"translation":[0.0,-0.0625,0.0],"left_rotation":[0.0,0.0,0.0,1.0],"scale":[1.0,1.0,1.0],"right_rotation":[0.0,0.0,0.0,1.0]}}
summon minecraft:item_display ~-5.5 ~2.42 ~15.5 {"Tags":["oa.practice_showcase"],"item":{"id":"minecraft:carrot_on_a_stick","count":1,"components":{"minecraft:item_model":"oa:yuttari"}},"item_display":"none","billboard":"center","view_range":0.55,"transformation":{"translation":[-0.0,0.0,-0.0],"left_rotation":[0.0,1.0,0.0,0.0],"scale":[1.0,1.0,1.0],"right_rotation":[0.0,0.0,0.0,1.0]}}
summon minecraft:item_display ~3.5 ~2.42 ~15.5 {"Tags":["oa.practice_showcase"],"item":{"id":"minecraft:carrot_on_a_stick","count":1,"components":{"minecraft:item_model":"oa:killing"}},"item_display":"none","billboard":"center","view_range":0.55,"transformation":{"translation":[-0.0,0.0,-0.0141],"left_rotation":[0.0,1.0,0.0,0.0],"scale":[1.0,1.0,1.0],"right_rotation":[0.0,0.0,0.0,1.0]}}
summon minecraft:item_display ~12.5 ~2.42 ~15.5 {"Tags":["oa.practice_showcase"],"item":{"id":"minecraft:carrot_on_a_stick","count":1,"components":{"minecraft:item_model":"oa:raji"}},"item_display":"none","billboard":"center","view_range":0.55,"transformation":{"translation":[-0.0,0.0719,0.0453],"left_rotation":[0.0,1.0,0.0,0.0],"scale":[1.0,1.0,1.0],"right_rotation":[0.0,0.0,0.0,1.0]}}
summon minecraft:item_display ~21.5 ~2.42 ~15.5 {"Tags":["oa.practice_showcase"],"item":{"id":"minecraft:carrot_on_a_stick","count":1,"components":{"minecraft:item_model":"oa:komame"}},"item_display":"none","billboard":"center","view_range":0.55,"transformation":{"translation":[0.0,0.0062,0.0],"left_rotation":[0.0,0.0,0.0,1.0],"scale":[1.0,1.0,1.0],"right_rotation":[0.0,0.0,0.0,1.0]}}
summon minecraft:item_display ~-23.5 ~2.42 ~21.5 {"Tags":["oa.practice_showcase"],"item":{"id":"minecraft:carrot_on_a_stick","count":1,"components":{"minecraft:item_model":"oa:nero"}},"item_display":"none","billboard":"center","view_range":0.55,"transformation":{"translation":[-0.1234,0.0312,0.0],"left_rotation":[0.0,0.0,0.0,1.0],"scale":[1.0,1.0,1.0],"right_rotation":[0.0,0.0,0.0,1.0]}}
summon minecraft:item_display ~-14.5 ~2.42 ~21.5 {"Tags":["oa.practice_showcase"],"item":{"id":"minecraft:totem_of_undying","count":1,"components":{"minecraft:item_model":"oa:yu"}},"item_display":"none","billboard":"center","view_range":0.55,"transformation":{"translation":[0.0,-0.0962,-0.0047],"left_rotation":[0.0,0.0,0.0,1.0],"scale":[1.0,1.0,1.0],"right_rotation":[0.0,0.0,0.0,1.0]}}
summon minecraft:item_display ~-5.5 ~2.42 ~21.5 {"Tags":["oa.practice_showcase"],"item":{"id":"minecraft:carrot_on_a_stick","count":1,"components":{"minecraft:item_model":"oa:hotchikisu"}},"item_display":"none","billboard":"center","view_range":0.55,"transformation":{"translation":[0.0266,0.2016,0.0],"left_rotation":[0.0,0.0,0.0,1.0],"scale":[1.0,1.0,1.0],"right_rotation":[0.0,0.0,0.0,1.0]}}
summon minecraft:item_display ~3.5 ~2.42 ~21.5 {"Tags":["oa.practice_showcase"],"item":{"id":"minecraft:carrot_on_a_stick","count":1,"components":{"minecraft:item_model":"oa:tayayuyu"}},"item_display":"none","billboard":"center","view_range":0.55,"transformation":{"translation":[0.0,0.0,0.0],"left_rotation":[0.0,1.0,0.0,0.0],"scale":[1.0,1.0,1.0],"right_rotation":[0.0,0.0,0.0,1.0]}}
summon minecraft:item_display ~12.5 ~2.42 ~21.5 {"Tags":["oa.practice_showcase"],"item":{"id":"minecraft:fire_charge","count":1,"components":{}},"item_display":"none","billboard":"center","view_range":0.55,"transformation":{"translation":[0.0,0.0,0.0],"left_rotation":[0.0,0.0,0.0,1.0],"scale":[1.0,1.0,1.0],"right_rotation":[0.0,0.0,0.0,1.0]}}
summon minecraft:item_display ~21.5 ~2.42 ~21.5 {"Tags":["oa.practice_showcase"],"item":{"id":"minecraft:carrot_on_a_stick","count":1,"components":{"minecraft:item_model":"oa:itori"}},"item_display":"none","billboard":"center","view_range":0.55,"transformation":{"translation":[0.0,0.0,0.0],"left_rotation":[0.0,0.0,0.0,1.0],"scale":[1.0,1.0,1.0],"right_rotation":[0.0,0.0,0.0,1.0]}}
fill ~-47 ~1 ~-34 ~-47 ~5 ~-34 minecraft:spruce_log
fill ~-49 ~4 ~-35 ~-45 ~4 ~-33 minecraft:spruce_leaves[persistent=true]
fill ~-48 ~5 ~-36 ~-46 ~5 ~-33 minecraft:spruce_leaves[persistent=true]
setblock ~-47 ~6 ~-34 minecraft:spruce_leaves[persistent=true]
fill ~-37 ~1 ~-28 ~-37 ~5 ~-28 minecraft:spruce_log
fill ~-39 ~4 ~-29 ~-35 ~4 ~-27 minecraft:spruce_leaves[persistent=true]
fill ~-38 ~5 ~-30 ~-36 ~5 ~-27 minecraft:spruce_leaves[persistent=true]
setblock ~-37 ~6 ~-28 minecraft:spruce_leaves[persistent=true]
fill ~-36 ~1 ~-11 ~-36 ~5 ~-11 minecraft:spruce_log
fill ~-38 ~4 ~-12 ~-34 ~4 ~-10 minecraft:spruce_leaves[persistent=true]
fill ~-37 ~5 ~-13 ~-35 ~5 ~-10 minecraft:spruce_leaves[persistent=true]
setblock ~-36 ~6 ~-11 minecraft:spruce_leaves[persistent=true]
fill ~-35 ~1 ~7 ~-35 ~5 ~7 minecraft:spruce_log
fill ~-37 ~4 ~6 ~-33 ~4 ~8 minecraft:spruce_leaves[persistent=true]
fill ~-36 ~5 ~5 ~-34 ~5 ~8 minecraft:spruce_leaves[persistent=true]
setblock ~-35 ~6 ~7 minecraft:spruce_leaves[persistent=true]
fill ~-39 ~1 ~23 ~-39 ~5 ~23 minecraft:spruce_log
fill ~-41 ~4 ~22 ~-37 ~4 ~24 minecraft:spruce_leaves[persistent=true]
fill ~-40 ~5 ~21 ~-38 ~5 ~24 minecraft:spruce_leaves[persistent=true]
setblock ~-39 ~6 ~23 minecraft:spruce_leaves[persistent=true]
fill ~-34 ~1 ~35 ~-34 ~5 ~35 minecraft:spruce_log
fill ~-36 ~4 ~34 ~-32 ~4 ~36 minecraft:spruce_leaves[persistent=true]
fill ~-35 ~5 ~33 ~-33 ~5 ~36 minecraft:spruce_leaves[persistent=true]
setblock ~-34 ~6 ~35 minecraft:spruce_leaves[persistent=true]
fill ~-19 ~1 ~34 ~-19 ~5 ~34 minecraft:spruce_log
fill ~-21 ~4 ~33 ~-17 ~4 ~35 minecraft:spruce_leaves[persistent=true]
fill ~-20 ~5 ~32 ~-18 ~5 ~35 minecraft:spruce_leaves[persistent=true]
setblock ~-19 ~6 ~34 minecraft:spruce_leaves[persistent=true]
fill ~-10 ~1 ~39 ~-10 ~5 ~39 minecraft:spruce_log
fill ~-12 ~4 ~38 ~-8 ~4 ~40 minecraft:spruce_leaves[persistent=true]
fill ~-11 ~5 ~37 ~-9 ~5 ~40 minecraft:spruce_leaves[persistent=true]
setblock ~-10 ~6 ~39 minecraft:spruce_leaves[persistent=true]
fill ~8 ~1 ~36 ~8 ~5 ~36 minecraft:spruce_log
fill ~6 ~4 ~35 ~10 ~4 ~37 minecraft:spruce_leaves[persistent=true]
fill ~7 ~5 ~34 ~9 ~5 ~37 minecraft:spruce_leaves[persistent=true]
setblock ~8 ~6 ~36 minecraft:spruce_leaves[persistent=true]
fill ~19 ~1 ~33 ~19 ~5 ~33 minecraft:spruce_log
fill ~17 ~4 ~32 ~21 ~4 ~34 minecraft:spruce_leaves[persistent=true]
fill ~18 ~5 ~31 ~20 ~5 ~34 minecraft:spruce_leaves[persistent=true]
setblock ~19 ~6 ~33 minecraft:spruce_leaves[persistent=true]
fill ~35 ~1 ~34 ~35 ~5 ~34 minecraft:spruce_log
fill ~33 ~4 ~33 ~37 ~4 ~35 minecraft:spruce_leaves[persistent=true]
fill ~34 ~5 ~32 ~36 ~5 ~35 minecraft:spruce_leaves[persistent=true]
setblock ~35 ~6 ~34 minecraft:spruce_leaves[persistent=true]
fill ~37 ~1 ~20 ~37 ~5 ~20 minecraft:spruce_log
fill ~35 ~4 ~19 ~39 ~4 ~21 minecraft:spruce_leaves[persistent=true]
fill ~36 ~5 ~18 ~38 ~5 ~21 minecraft:spruce_leaves[persistent=true]
setblock ~37 ~6 ~20 minecraft:spruce_leaves[persistent=true]
fill ~39 ~1 ~8 ~39 ~5 ~8 minecraft:spruce_log
fill ~37 ~4 ~7 ~41 ~4 ~9 minecraft:spruce_leaves[persistent=true]
fill ~38 ~5 ~6 ~40 ~5 ~9 minecraft:spruce_leaves[persistent=true]
setblock ~39 ~6 ~8 minecraft:spruce_leaves[persistent=true]
fill ~33 ~1 ~-11 ~33 ~5 ~-11 minecraft:spruce_log
fill ~31 ~4 ~-12 ~35 ~4 ~-10 minecraft:spruce_leaves[persistent=true]
fill ~32 ~5 ~-13 ~34 ~5 ~-10 minecraft:spruce_leaves[persistent=true]
setblock ~33 ~6 ~-11 minecraft:spruce_leaves[persistent=true]
fill ~36 ~1 ~-24 ~36 ~5 ~-24 minecraft:spruce_log
fill ~34 ~4 ~-25 ~38 ~4 ~-23 minecraft:spruce_leaves[persistent=true]
fill ~35 ~5 ~-26 ~37 ~5 ~-23 minecraft:spruce_leaves[persistent=true]
setblock ~36 ~6 ~-24 minecraft:spruce_leaves[persistent=true]
fill ~33 ~1 ~-36 ~33 ~5 ~-36 minecraft:spruce_log
fill ~31 ~4 ~-37 ~35 ~4 ~-35 minecraft:spruce_leaves[persistent=true]
fill ~32 ~5 ~-38 ~34 ~5 ~-35 minecraft:spruce_leaves[persistent=true]
setblock ~33 ~6 ~-36 minecraft:spruce_leaves[persistent=true]
fill ~18 ~1 ~-36 ~18 ~5 ~-36 minecraft:spruce_log
fill ~16 ~4 ~-37 ~20 ~4 ~-35 minecraft:spruce_leaves[persistent=true]
fill ~17 ~5 ~-38 ~19 ~5 ~-35 minecraft:spruce_leaves[persistent=true]
setblock ~18 ~6 ~-36 minecraft:spruce_leaves[persistent=true]
fill ~9 ~1 ~-34 ~9 ~5 ~-34 minecraft:spruce_log
fill ~7 ~4 ~-35 ~11 ~4 ~-33 minecraft:spruce_leaves[persistent=true]
fill ~8 ~5 ~-36 ~10 ~5 ~-33 minecraft:spruce_leaves[persistent=true]
setblock ~9 ~6 ~-34 minecraft:spruce_leaves[persistent=true]
fill ~-11 ~1 ~-36 ~-11 ~5 ~-36 minecraft:spruce_log
fill ~-13 ~4 ~-37 ~-9 ~4 ~-35 minecraft:spruce_leaves[persistent=true]
fill ~-12 ~5 ~-38 ~-10 ~5 ~-35 minecraft:spruce_leaves[persistent=true]
setblock ~-11 ~6 ~-36 minecraft:spruce_leaves[persistent=true]
fill ~-23 ~1 ~-33 ~-23 ~5 ~-33 minecraft:spruce_log
fill ~-25 ~4 ~-34 ~-21 ~4 ~-32 minecraft:spruce_leaves[persistent=true]
fill ~-24 ~5 ~-35 ~-22 ~5 ~-32 minecraft:spruce_leaves[persistent=true]
setblock ~-23 ~6 ~-33 minecraft:spruce_leaves[persistent=true]
fill ~-41 ~ ~-34 ~-39 ~ ~-32 minecraft:moss_block
setblock ~-40 ~1 ~-33 minecraft:azalea_leaves[persistent=true]
setblock ~-41 ~1 ~-33 minecraft:mossy_cobblestone
setblock ~-39 ~1 ~-32 minecraft:pink_petals[flower_amount=3]
fill ~-38 ~ ~-21 ~-36 ~ ~-19 minecraft:moss_block
setblock ~-37 ~1 ~-20 minecraft:azalea_leaves[persistent=true]
setblock ~-38 ~1 ~-20 minecraft:mossy_cobblestone
setblock ~-36 ~1 ~-19 minecraft:pink_petals[flower_amount=3]
fill ~-37 ~ ~11 ~-35 ~ ~13 minecraft:moss_block
setblock ~-36 ~1 ~12 minecraft:azalea_leaves[persistent=true]
setblock ~-37 ~1 ~12 minecraft:mossy_cobblestone
setblock ~-35 ~1 ~13 minecraft:pink_petals[flower_amount=3]
fill ~-36 ~ ~28 ~-34 ~ ~30 minecraft:moss_block
setblock ~-35 ~1 ~29 minecraft:azalea_leaves[persistent=true]
setblock ~-36 ~1 ~29 minecraft:mossy_cobblestone
setblock ~-34 ~1 ~30 minecraft:pink_petals[flower_amount=3]
fill ~-26 ~ ~36 ~-24 ~ ~38 minecraft:moss_block
setblock ~-25 ~1 ~37 minecraft:azalea_leaves[persistent=true]
setblock ~-26 ~1 ~37 minecraft:mossy_cobblestone
setblock ~-24 ~1 ~38 minecraft:pink_petals[flower_amount=3]
fill ~-13 ~ ~29 ~-11 ~ ~31 minecraft:moss_block
setblock ~-12 ~1 ~30 minecraft:azalea_leaves[persistent=true]
setblock ~-13 ~1 ~30 minecraft:mossy_cobblestone
setblock ~-11 ~1 ~31 minecraft:pink_petals[flower_amount=3]
fill ~13 ~ ~30 ~15 ~ ~32 minecraft:moss_block
setblock ~14 ~1 ~31 minecraft:azalea_leaves[persistent=true]
setblock ~13 ~1 ~31 minecraft:mossy_cobblestone
setblock ~15 ~1 ~32 minecraft:pink_petals[flower_amount=3]
fill ~25 ~ ~35 ~27 ~ ~37 minecraft:moss_block
setblock ~26 ~1 ~36 minecraft:azalea_leaves[persistent=true]
setblock ~25 ~1 ~36 minecraft:mossy_cobblestone
setblock ~27 ~1 ~37 minecraft:pink_petals[flower_amount=3]
fill ~34 ~ ~25 ~36 ~ ~27 minecraft:moss_block
setblock ~35 ~1 ~26 minecraft:azalea_leaves[persistent=true]
setblock ~34 ~1 ~26 minecraft:mossy_cobblestone
setblock ~36 ~1 ~27 minecraft:pink_petals[flower_amount=3]
fill ~35 ~ ~10 ~37 ~ ~12 minecraft:moss_block
setblock ~36 ~1 ~11 minecraft:azalea_leaves[persistent=true]
setblock ~35 ~1 ~11 minecraft:mossy_cobblestone
setblock ~37 ~1 ~12 minecraft:pink_petals[flower_amount=3]
fill ~33 ~ ~-16 ~35 ~ ~-14 minecraft:moss_block
setblock ~34 ~1 ~-15 minecraft:azalea_leaves[persistent=true]
setblock ~33 ~1 ~-15 minecraft:mossy_cobblestone
setblock ~35 ~1 ~-14 minecraft:pink_petals[flower_amount=3]
fill ~28 ~ ~-33 ~30 ~ ~-31 minecraft:moss_block
setblock ~29 ~1 ~-32 minecraft:azalea_leaves[persistent=true]
setblock ~28 ~1 ~-32 minecraft:mossy_cobblestone
setblock ~30 ~1 ~-31 minecraft:pink_petals[flower_amount=3]
fill ~20 ~ ~-40 ~22 ~ ~-38 minecraft:moss_block
setblock ~21 ~1 ~-39 minecraft:azalea_leaves[persistent=true]
setblock ~20 ~1 ~-39 minecraft:mossy_cobblestone
setblock ~22 ~1 ~-38 minecraft:pink_petals[flower_amount=3]
fill ~-13 ~ ~-40 ~-11 ~ ~-38 minecraft:moss_block
setblock ~-12 ~1 ~-39 minecraft:azalea_leaves[persistent=true]
setblock ~-13 ~1 ~-39 minecraft:mossy_cobblestone
setblock ~-11 ~1 ~-38 minecraft:pink_petals[flower_amount=3]
setblock ~-42 ~1 ~-40 minecraft:stone_bricks
setblock ~-42 ~2 ~-40 minecraft:stone_brick_wall
setblock ~-42 ~3 ~-40 minecraft:lantern
setblock ~-42 ~1 ~40 minecraft:stone_bricks
setblock ~-42 ~2 ~40 minecraft:stone_brick_wall
setblock ~-42 ~3 ~40 minecraft:lantern
setblock ~42 ~1 ~-40 minecraft:stone_bricks
setblock ~42 ~2 ~-40 minecraft:stone_brick_wall
setblock ~42 ~3 ~-40 minecraft:lantern
setblock ~42 ~1 ~40 minecraft:stone_bricks
setblock ~42 ~2 ~40 minecraft:stone_brick_wall
setblock ~42 ~3 ~40 minecraft:lantern
setblock ~-35 ~1 ~-4 minecraft:stone_bricks
setblock ~-35 ~2 ~-4 minecraft:stone_brick_wall
setblock ~-35 ~3 ~-4 minecraft:lantern
setblock ~35 ~1 ~-4 minecraft:stone_bricks
setblock ~35 ~2 ~-4 minecraft:stone_brick_wall
setblock ~35 ~3 ~-4 minecraft:lantern
setblock ~-3 ~1 ~35 minecraft:stone_bricks
setblock ~-3 ~2 ~35 minecraft:stone_brick_wall
setblock ~-3 ~3 ~35 minecraft:lantern
setblock ~3 ~1 ~35 minecraft:stone_bricks
setblock ~3 ~2 ~35 minecraft:stone_brick_wall
setblock ~3 ~3 ~35 minecraft:lantern
setblock ~-3 ~1 ~-37 minecraft:stone_bricks
setblock ~-3 ~2 ~-37 minecraft:stone_brick_wall
setblock ~-3 ~3 ~-37 minecraft:lantern
setblock ~3 ~1 ~-37 minecraft:stone_bricks
setblock ~3 ~2 ~-37 minecraft:stone_brick_wall
setblock ~3 ~3 ~-37 minecraft:lantern
fill ~-7 ~ ~26 ~7 ~ ~31 minecraft:stone_bricks
fill ~-7 ~1 ~30 ~7 ~1 ~30 minecraft:dark_oak_planks
fill ~-7 ~3 ~29 ~7 ~3 ~31 minecraft:dark_oak_slab[type=top]
setblock ~-7 ~2 ~30 minecraft:lantern
setblock ~7 ~2 ~30 minecraft:lantern
summon minecraft:text_display ~0.5 ~3.8 ~29.5 {Tags:["oa.practice_controls"],text:{text:"庭園の操作盤",color:"gold",bold:1b},billboard:"center",shadow:1b,view_range:0.7f}
setblock ~-6 ~2 ~30 minecraft:stone_button[face=floor,facing=north]
summon minecraft:marker ~-5.5 ~2 ~30.5 {Tags:["oa.physical_button","oa.button_practice","oa.practice_controls"],data:{action:"practice/click/clear"}}
summon minecraft:text_display ~-5.5 ~2.85 ~30.5 {Tags:["oa.practice_controls"],text:{text:"晴れ",color:"aqua"},billboard:"center",shadow:1b,view_range:0.5f}
setblock ~-3 ~2 ~30 minecraft:stone_button[face=floor,facing=north]
summon minecraft:marker ~-2.5 ~2 ~30.5 {Tags:["oa.physical_button","oa.button_practice","oa.practice_controls"],data:{action:"practice/click/rain"}}
summon minecraft:text_display ~-2.5 ~2.85 ~30.5 {Tags:["oa.practice_controls"],text:{text:"雨",color:"aqua"},billboard:"center",shadow:1b,view_range:0.5f}
setblock ~0 ~2 ~30 minecraft:stone_button[face=floor,facing=north]
summon minecraft:marker ~0.5 ~2 ~30.5 {Tags:["oa.physical_button","oa.button_practice","oa.practice_controls"],data:{action:"practice/click/day"}}
summon minecraft:text_display ~0.5 ~2.85 ~30.5 {Tags:["oa.practice_controls"],text:{text:"昼",color:"aqua"},billboard:"center",shadow:1b,view_range:0.5f}
setblock ~3 ~2 ~30 minecraft:stone_button[face=floor,facing=north]
summon minecraft:marker ~3.5 ~2 ~30.5 {Tags:["oa.physical_button","oa.button_practice","oa.practice_controls"],data:{action:"practice/click/night"}}
summon minecraft:text_display ~3.5 ~2.85 ~30.5 {Tags:["oa.practice_controls"],text:{text:"夜",color:"aqua"},billboard:"center",shadow:1b,view_range:0.5f}
setblock ~6 ~2 ~30 minecraft:stone_button[face=floor,facing=north]
summon minecraft:marker ~6.5 ~2 ~30.5 {Tags:["oa.physical_button","oa.button_practice","oa.practice_controls"],data:{action:"practice/click/cooldown"}}
summon minecraft:text_display ~6.5 ~2.85 ~30.5 {Tags:["oa.practice_controls"],text:{text:"CTリセット",color:"aqua"},billboard:"center",shadow:1b,view_range:0.5f}

fill ~-5 ~4 ~-24 ~5 ~4 ~-17 minecraft:stripped_dark_oak_log[axis=x]
fill ~-6 ~5 ~-26 ~6 ~5 ~-16 minecraft:deepslate_tiles
fill ~-6 ~5 ~-26 ~6 ~5 ~-26 minecraft:deepslate_tile_stairs[facing=south]
fill ~-6 ~5 ~-16 ~6 ~5 ~-16 minecraft:deepslate_tile_stairs[facing=north]
fill ~-6 ~6 ~-25 ~6 ~6 ~-17 minecraft:deepslate_tiles
fill ~-6 ~6 ~-25 ~6 ~6 ~-25 minecraft:deepslate_tile_stairs[facing=south]
fill ~-6 ~6 ~-17 ~6 ~6 ~-17 minecraft:deepslate_tile_stairs[facing=north]
fill ~-6 ~7 ~-24 ~6 ~7 ~-18 minecraft:deepslate_tiles
fill ~-6 ~7 ~-24 ~6 ~7 ~-24 minecraft:deepslate_tile_stairs[facing=south]
fill ~-6 ~7 ~-18 ~6 ~7 ~-18 minecraft:deepslate_tile_stairs[facing=north]
fill ~-6 ~8 ~-23 ~6 ~8 ~-19 minecraft:deepslate_tiles
fill ~-6 ~8 ~-23 ~6 ~8 ~-23 minecraft:deepslate_tile_stairs[facing=south]
fill ~-6 ~8 ~-19 ~6 ~8 ~-19 minecraft:deepslate_tile_stairs[facing=north]
fill ~-6 ~9 ~-22 ~6 ~9 ~-20 minecraft:deepslate_tiles
fill ~-6 ~9 ~-22 ~6 ~9 ~-22 minecraft:deepslate_tile_stairs[facing=south]
fill ~-6 ~9 ~-20 ~6 ~9 ~-20 minecraft:deepslate_tile_stairs[facing=north]
fill ~-6 ~10 ~-21 ~6 ~10 ~-21 minecraft:deepslate_tile_slab[type=bottom]
fill ~-5 ~6 ~-25 ~-5 ~6 ~-17 minecraft:deepslate_tiles
fill ~-5 ~7 ~-24 ~-5 ~7 ~-18 minecraft:deepslate_tiles
fill ~-5 ~8 ~-23 ~-5 ~8 ~-19 minecraft:deepslate_tiles
fill ~-5 ~9 ~-22 ~-5 ~9 ~-20 minecraft:deepslate_tiles
fill ~5 ~6 ~-25 ~5 ~6 ~-17 minecraft:deepslate_tiles
fill ~5 ~7 ~-24 ~5 ~7 ~-18 minecraft:deepslate_tiles
fill ~5 ~8 ~-23 ~5 ~8 ~-19 minecraft:deepslate_tiles
fill ~5 ~9 ~-22 ~5 ~9 ~-20 minecraft:deepslate_tiles
fill ~-4 ~0 ~-23 ~4 ~0 ~-18 minecraft:bamboo_mosaic
setblock ~-4 ~3 ~-18 minecraft:lantern[hanging=true]
setblock ~4 ~3 ~-18 minecraft:lantern[hanging=true]
summon minecraft:text_display ~0.5 ~3.5 ~-16.7 {"Tags":["oa.practice_landmark"],"text":{"text":"庭園の東屋","color":"gold","bold":true},"billboard":"center","shadow":true,"view_range":0.55}
fill ~-43 ~1 ~13 ~-30 ~13 ~27 minecraft:air
fill ~-43 ~1 ~13 ~-30 ~2 ~27 minecraft:mossy_stone_bricks
fill ~-42 ~3 ~14 ~-31 ~3 ~26 minecraft:moss_block
fill ~-41 ~3 ~16 ~-33 ~3 ~24 minecraft:dark_oak_planks
fill ~-40 ~3 ~17 ~-34 ~3 ~23 minecraft:bamboo_mosaic
fill ~-41 ~4 ~16 ~-41 ~7 ~16 minecraft:stripped_dark_oak_log
fill ~-41 ~4 ~24 ~-41 ~7 ~24 minecraft:stripped_dark_oak_log
fill ~-41 ~4 ~17 ~-41 ~6 ~23 minecraft:white_terracotta
fill ~-33 ~4 ~16 ~-33 ~7 ~16 minecraft:stripped_dark_oak_log
fill ~-33 ~4 ~24 ~-33 ~7 ~24 minecraft:stripped_dark_oak_log
fill ~-33 ~4 ~17 ~-33 ~6 ~23 minecraft:white_terracotta
fill ~-40 ~4 ~16 ~-34 ~6 ~16 minecraft:white_terracotta
fill ~-41 ~7 ~16 ~-33 ~7 ~24 minecraft:dark_oak_planks
fill ~-42 ~8 ~15 ~-32 ~8 ~25 minecraft:deepslate_tiles
fill ~-42 ~8 ~15 ~-32 ~8 ~15 minecraft:deepslate_tile_stairs[facing=south]
fill ~-42 ~8 ~25 ~-32 ~8 ~25 minecraft:deepslate_tile_stairs[facing=north]
fill ~-42 ~9 ~16 ~-32 ~9 ~24 minecraft:deepslate_tiles
fill ~-42 ~9 ~16 ~-32 ~9 ~16 minecraft:deepslate_tile_stairs[facing=south]
fill ~-42 ~9 ~24 ~-32 ~9 ~24 minecraft:deepslate_tile_stairs[facing=north]
fill ~-42 ~10 ~17 ~-32 ~10 ~23 minecraft:deepslate_tiles
fill ~-42 ~10 ~17 ~-32 ~10 ~17 minecraft:deepslate_tile_stairs[facing=south]
fill ~-42 ~10 ~23 ~-32 ~10 ~23 minecraft:deepslate_tile_stairs[facing=north]
fill ~-42 ~11 ~18 ~-32 ~11 ~22 minecraft:deepslate_tiles
fill ~-42 ~11 ~18 ~-32 ~11 ~18 minecraft:deepslate_tile_stairs[facing=south]
fill ~-42 ~11 ~22 ~-32 ~11 ~22 minecraft:deepslate_tile_stairs[facing=north]
fill ~-42 ~12 ~19 ~-32 ~12 ~21 minecraft:deepslate_tiles
fill ~-42 ~12 ~19 ~-32 ~12 ~19 minecraft:deepslate_tile_stairs[facing=south]
fill ~-42 ~12 ~21 ~-32 ~12 ~21 minecraft:deepslate_tile_stairs[facing=north]
fill ~-42 ~13 ~20 ~-32 ~13 ~20 minecraft:deepslate_tile_slab[type=bottom]
fill ~-41 ~9 ~16 ~-41 ~9 ~24 minecraft:deepslate_tiles
fill ~-41 ~10 ~17 ~-41 ~10 ~23 minecraft:deepslate_tiles
fill ~-41 ~11 ~18 ~-41 ~11 ~22 minecraft:deepslate_tiles
fill ~-41 ~12 ~19 ~-41 ~12 ~21 minecraft:deepslate_tiles
fill ~-33 ~9 ~16 ~-33 ~9 ~24 minecraft:deepslate_tiles
fill ~-33 ~10 ~17 ~-33 ~10 ~23 minecraft:deepslate_tiles
fill ~-33 ~11 ~18 ~-33 ~11 ~22 minecraft:deepslate_tiles
fill ~-33 ~12 ~19 ~-33 ~12 ~21 minecraft:deepslate_tiles
setblock ~-39 ~6 ~23 minecraft:lantern[hanging=true]
setblock ~-35 ~6 ~23 minecraft:lantern[hanging=true]
fill ~-39 ~1 ~25 ~-35 ~3 ~28 minecraft:air
fill ~-39 ~3 ~25 ~-35 ~3 ~25 minecraft:stone_brick_stairs[facing=north]
fill ~-39 ~2 ~26 ~-35 ~2 ~26 minecraft:stone_brick_stairs[facing=north]
fill ~-39 ~1 ~27 ~-35 ~1 ~27 minecraft:stone_brick_stairs[facing=north]
fill ~-39 ~0 ~28 ~-35 ~0 ~28 minecraft:stone_brick_stairs[facing=north]
fill ~-39 ~0 ~29 ~-35 ~0 ~41 minecraft:gravel
summon minecraft:text_display ~-36.5 ~5 ~25 {"Tags":["oa.practice_landmark"],"text":{"text":"苔庭の茶室","color":"gold","bold":true},"billboard":"center","shadow":true,"view_range":0.55}
fill ~29 ~1 ~-29 ~43 ~15 ~-15 minecraft:air
fill ~29 ~1 ~-29 ~43 ~2 ~-15 minecraft:mossy_stone_bricks
fill ~30 ~3 ~-28 ~42 ~3 ~-16 minecraft:moss_block
fill ~31 ~4 ~-27 ~41 ~4 ~-17 minecraft:spruce_planks
fill ~31 ~4 ~-27 ~41 ~4 ~-17 minecraft:bamboo_mosaic
fill ~31 ~5 ~-27 ~31 ~8 ~-27 minecraft:stripped_spruce_log
fill ~31 ~5 ~-17 ~31 ~8 ~-17 minecraft:stripped_spruce_log
fill ~41 ~5 ~-27 ~41 ~8 ~-27 minecraft:stripped_spruce_log
fill ~41 ~5 ~-17 ~41 ~8 ~-17 minecraft:stripped_spruce_log
fill ~31 ~8 ~-27 ~41 ~8 ~-17 minecraft:spruce_planks
fill ~30 ~9 ~-28 ~42 ~9 ~-16 minecraft:deepslate_tiles
fill ~30 ~9 ~-28 ~42 ~9 ~-28 minecraft:deepslate_tile_stairs[facing=south]
fill ~30 ~9 ~-16 ~42 ~9 ~-16 minecraft:deepslate_tile_stairs[facing=north]
fill ~30 ~10 ~-27 ~42 ~10 ~-17 minecraft:deepslate_tiles
fill ~30 ~10 ~-27 ~42 ~10 ~-27 minecraft:deepslate_tile_stairs[facing=south]
fill ~30 ~10 ~-17 ~42 ~10 ~-17 minecraft:deepslate_tile_stairs[facing=north]
fill ~30 ~11 ~-26 ~42 ~11 ~-18 minecraft:deepslate_tiles
fill ~30 ~11 ~-26 ~42 ~11 ~-26 minecraft:deepslate_tile_stairs[facing=south]
fill ~30 ~11 ~-18 ~42 ~11 ~-18 minecraft:deepslate_tile_stairs[facing=north]
fill ~30 ~12 ~-25 ~42 ~12 ~-19 minecraft:deepslate_tiles
fill ~30 ~12 ~-25 ~42 ~12 ~-25 minecraft:deepslate_tile_stairs[facing=south]
fill ~30 ~12 ~-19 ~42 ~12 ~-19 minecraft:deepslate_tile_stairs[facing=north]
fill ~30 ~13 ~-24 ~42 ~13 ~-20 minecraft:deepslate_tiles
fill ~30 ~13 ~-24 ~42 ~13 ~-24 minecraft:deepslate_tile_stairs[facing=south]
fill ~30 ~13 ~-20 ~42 ~13 ~-20 minecraft:deepslate_tile_stairs[facing=north]
fill ~30 ~14 ~-23 ~42 ~14 ~-21 minecraft:deepslate_tiles
fill ~30 ~14 ~-23 ~42 ~14 ~-23 minecraft:deepslate_tile_stairs[facing=south]
fill ~30 ~14 ~-21 ~42 ~14 ~-21 minecraft:deepslate_tile_stairs[facing=north]
fill ~30 ~15 ~-22 ~42 ~15 ~-22 minecraft:deepslate_tile_slab[type=bottom]
fill ~31 ~10 ~-27 ~31 ~10 ~-17 minecraft:deepslate_tiles
fill ~31 ~11 ~-26 ~31 ~11 ~-18 minecraft:deepslate_tiles
fill ~31 ~12 ~-25 ~31 ~12 ~-19 minecraft:deepslate_tiles
fill ~31 ~13 ~-24 ~31 ~13 ~-20 minecraft:deepslate_tiles
fill ~31 ~14 ~-23 ~31 ~14 ~-21 minecraft:deepslate_tiles
fill ~41 ~10 ~-27 ~41 ~10 ~-17 minecraft:deepslate_tiles
fill ~41 ~11 ~-26 ~41 ~11 ~-18 minecraft:deepslate_tiles
fill ~41 ~12 ~-25 ~41 ~12 ~-19 minecraft:deepslate_tiles
fill ~41 ~13 ~-24 ~41 ~13 ~-20 minecraft:deepslate_tiles
fill ~41 ~14 ~-23 ~41 ~14 ~-21 minecraft:deepslate_tiles
fill ~34 ~4 ~-16 ~38 ~4 ~-16 minecraft:stone_brick_stairs[facing=north]
fill ~34 ~3 ~-15 ~38 ~3 ~-15 minecraft:stone_brick_stairs[facing=north]
fill ~34 ~2 ~-14 ~38 ~2 ~-14 minecraft:stone_brick_stairs[facing=north]
fill ~34 ~1 ~-13 ~38 ~1 ~-13 minecraft:stone_brick_stairs[facing=north]
fill ~34 ~0 ~-12 ~38 ~0 ~-12 minecraft:stone_brick_stairs[facing=north]
fill ~34 ~0 ~-11 ~38 ~0 ~-5 minecraft:gravel
setblock ~32 ~7 ~-18 minecraft:lantern[hanging=true]
setblock ~40 ~7 ~-18 minecraft:lantern[hanging=true]
summon minecraft:text_display ~36.5 ~6 ~-16 {"Tags":["oa.practice_landmark"],"text":{"text":"月見台","color":"gold","bold":true},"billboard":"center","shadow":true,"view_range":0.55}
fill ~28 ~1 ~21 ~40 ~20 ~35 minecraft:air
fill ~28 ~0 ~21 ~40 ~0 ~35 minecraft:stone_bricks
fill ~31 ~1 ~24 ~37 ~4 ~30 minecraft:red_terracotta
fill ~33 ~1 ~30 ~35 ~2 ~30 minecraft:air
fill ~31 ~1 ~24 ~31 ~4 ~24 minecraft:stripped_dark_oak_log
fill ~31 ~1 ~30 ~31 ~4 ~30 minecraft:stripped_dark_oak_log
fill ~37 ~1 ~24 ~37 ~4 ~24 minecraft:stripped_dark_oak_log
fill ~37 ~1 ~30 ~37 ~4 ~30 minecraft:stripped_dark_oak_log
fill ~29 ~5 ~22 ~39 ~5 ~32 minecraft:deepslate_tiles
fill ~30 ~6 ~23 ~38 ~6 ~31 minecraft:deepslate_tiles
fill ~31 ~7 ~24 ~37 ~8 ~30 minecraft:red_terracotta
fill ~30 ~9 ~23 ~38 ~9 ~31 minecraft:deepslate_tiles
fill ~31 ~10 ~24 ~37 ~10 ~30 minecraft:deepslate_tiles
fill ~32 ~11 ~25 ~36 ~12 ~29 minecraft:red_terracotta
fill ~31 ~13 ~24 ~37 ~13 ~30 minecraft:deepslate_tiles
fill ~32 ~14 ~25 ~36 ~14 ~29 minecraft:deepslate_tiles
fill ~34 ~15 ~27 ~34 ~18 ~27 minecraft:polished_blackstone_wall
setblock ~34 ~19 ~27 minecraft:lightning_rod
summon minecraft:text_display ~34.5 ~3 ~31 {"Tags":["oa.practice_landmark"],"text":{"text":"三重塔","color":"gold","bold":true},"billboard":"center","shadow":true,"view_range":0.55}
fill ~-4 ~1 ~-38 ~-4 ~5 ~-38 minecraft:red_terracotta
setblock ~-4 ~0 ~-38 minecraft:polished_blackstone
fill ~4 ~1 ~-38 ~4 ~5 ~-38 minecraft:red_terracotta
setblock ~4 ~0 ~-38 minecraft:polished_blackstone
fill ~-5 ~4 ~-38 ~5 ~4 ~-38 minecraft:red_terracotta
fill ~-6 ~6 ~-38 ~6 ~6 ~-38 minecraft:red_terracotta
fill ~-7 ~7 ~-38 ~7 ~7 ~-38 minecraft:deepslate_tiles
fill ~-1 ~0 ~-45 ~1 ~0 ~-28 minecraft:stone_bricks
setblock ~-6 ~1 ~-36 minecraft:mossy_stone_bricks
setblock ~-6 ~2 ~-36 minecraft:stone_brick_wall
setblock ~-6 ~3 ~-36 minecraft:lantern
setblock ~6 ~1 ~-36 minecraft:mossy_stone_bricks
setblock ~6 ~2 ~-36 minecraft:stone_brick_wall
setblock ~6 ~3 ~-36 minecraft:lantern
setblock ~-27 ~1 ~10 minecraft:mossy_stone_bricks
setblock ~-27 ~2 ~10 minecraft:stone_brick_wall
setblock ~-27 ~3 ~10 minecraft:lantern
setblock ~26 ~1 ~-13 minecraft:mossy_stone_bricks
setblock ~26 ~2 ~-13 minecraft:stone_brick_wall
setblock ~26 ~3 ~-13 minecraft:lantern
setblock ~26 ~1 ~29 minecraft:mossy_stone_bricks
setblock ~26 ~2 ~29 minecraft:stone_brick_wall
setblock ~26 ~3 ~29 minecraft:lantern
setblock ~-7 ~1 ~-31 minecraft:mossy_stone_bricks
setblock ~-7 ~2 ~-31 minecraft:stone_brick_wall
setblock ~-7 ~3 ~-31 minecraft:lantern
setblock ~7 ~1 ~-31 minecraft:mossy_stone_bricks
setblock ~7 ~2 ~-31 minecraft:stone_brick_wall
setblock ~7 ~3 ~-31 minecraft:lantern
fill ~-30 ~0 ~4 ~-28 ~0 ~6 minecraft:chiseled_stone_bricks
fill ~-29 ~1 ~5 ~-29 ~4 ~5 minecraft:air
setblock ~-29 ~0 ~5 minecraft:bricks
setblock ~-29 ~1 ~5 minecraft:stone_pressure_plate
summon minecraft:text_display ~-28.5 ~1.8 ~5.5 {"Tags":["oa.practice_landmark"],"text":{"text":"ジャンプパッド","color":"gold","bold":true},"billboard":"center","shadow":true,"view_range":0.55}
fill ~27 ~0 ~-7 ~29 ~0 ~-5 minecraft:chiseled_stone_bricks
fill ~28 ~1 ~-6 ~28 ~4 ~-6 minecraft:air
setblock ~28 ~0 ~-6 minecraft:bricks
setblock ~28 ~1 ~-6 minecraft:stone_pressure_plate
summon minecraft:text_display ~28.5 ~1.8 ~-5.5 {"Tags":["oa.practice_landmark"],"text":{"text":"ジャンプパッド","color":"gold","bold":true},"billboard":"center","shadow":true,"view_range":0.55}
fill ~7 ~0 ~-35 ~9 ~0 ~-33 minecraft:chiseled_stone_bricks
fill ~8 ~1 ~-34 ~8 ~4 ~-34 minecraft:air
setblock ~8 ~0 ~-34 minecraft:bricks
setblock ~8 ~1 ~-34 minecraft:stone_pressure_plate
summon minecraft:text_display ~8.5 ~1.8 ~-33.5 {"Tags":["oa.practice_landmark"],"text":{"text":"ジャンプパッド","color":"gold","bold":true},"billboard":"center","shadow":true,"view_range":0.55}
fill ~18 ~0 ~34 ~20 ~0 ~36 minecraft:chiseled_stone_bricks
fill ~19 ~1 ~35 ~19 ~4 ~35 minecraft:air
setblock ~19 ~0 ~35 minecraft:bricks
setblock ~19 ~1 ~35 minecraft:stone_pressure_plate
summon minecraft:text_display ~19.5 ~1.8 ~35.5 {"Tags":["oa.practice_landmark"],"text":{"text":"ジャンプパッド","color":"gold","bold":true},"billboard":"center","shadow":true,"view_range":0.55}

fill ~-47 ~1 ~-24 ~-47 ~1 ~-24 minecraft:stone
setblock ~-47 ~1 ~-24 minecraft:moss_block
fill ~-47 ~1 ~-23 ~-47 ~1 ~-23 minecraft:mossy_cobblestone
setblock ~-47 ~1 ~-23 minecraft:moss_block
fill ~-47 ~1 ~-22 ~-47 ~2 ~-22 minecraft:stone
setblock ~-47 ~2 ~-22 minecraft:moss_block
fill ~-47 ~1 ~-21 ~-47 ~2 ~-21 minecraft:stone
setblock ~-47 ~2 ~-21 minecraft:grass_block
fill ~-47 ~1 ~-20 ~-47 ~2 ~-20 minecraft:stone
setblock ~-47 ~2 ~-20 minecraft:moss_block
fill ~-47 ~1 ~-19 ~-47 ~2 ~-19 minecraft:stone
setblock ~-47 ~2 ~-19 minecraft:moss_block
fill ~-47 ~1 ~-18 ~-47 ~2 ~-18 minecraft:mossy_cobblestone
setblock ~-47 ~2 ~-18 minecraft:moss_block
fill ~-47 ~1 ~-17 ~-47 ~2 ~-17 minecraft:stone
setblock ~-47 ~2 ~-17 minecraft:grass_block
fill ~-47 ~1 ~-16 ~-47 ~2 ~-16 minecraft:stone
setblock ~-47 ~2 ~-16 minecraft:moss_block
fill ~-47 ~1 ~-15 ~-47 ~2 ~-15 minecraft:stone
setblock ~-47 ~2 ~-15 minecraft:moss_block
fill ~-47 ~1 ~-14 ~-47 ~2 ~-14 minecraft:stone
setblock ~-47 ~2 ~-14 minecraft:moss_block
fill ~-47 ~1 ~-13 ~-47 ~1 ~-13 minecraft:mossy_cobblestone
setblock ~-47 ~1 ~-13 minecraft:grass_block
fill ~-47 ~1 ~-12 ~-47 ~1 ~-12 minecraft:stone
setblock ~-47 ~1 ~-12 minecraft:moss_block
fill ~-46 ~1 ~-26 ~-46 ~1 ~-26 minecraft:stone
setblock ~-46 ~1 ~-26 minecraft:grass_block
fill ~-46 ~1 ~-25 ~-46 ~1 ~-25 minecraft:stone
setblock ~-46 ~1 ~-25 minecraft:moss_block
fill ~-46 ~1 ~-24 ~-46 ~2 ~-24 minecraft:mossy_cobblestone
setblock ~-46 ~2 ~-24 minecraft:moss_block
fill ~-46 ~1 ~-23 ~-46 ~2 ~-23 minecraft:stone
setblock ~-46 ~2 ~-23 minecraft:moss_block
fill ~-46 ~1 ~-22 ~-46 ~3 ~-22 minecraft:stone
setblock ~-46 ~3 ~-22 minecraft:grass_block
fill ~-46 ~1 ~-21 ~-46 ~3 ~-21 minecraft:stone
setblock ~-46 ~3 ~-21 minecraft:moss_block
fill ~-46 ~1 ~-20 ~-46 ~3 ~-20 minecraft:stone
setblock ~-46 ~3 ~-20 minecraft:moss_block
fill ~-46 ~1 ~-19 ~-46 ~3 ~-19 minecraft:mossy_cobblestone
setblock ~-46 ~3 ~-19 minecraft:moss_block
fill ~-46 ~1 ~-18 ~-46 ~3 ~-18 minecraft:stone
setblock ~-46 ~3 ~-18 minecraft:grass_block
fill ~-46 ~1 ~-17 ~-46 ~3 ~-17 minecraft:stone
setblock ~-46 ~3 ~-17 minecraft:moss_block
fill ~-46 ~1 ~-16 ~-46 ~3 ~-16 minecraft:stone
setblock ~-46 ~3 ~-16 minecraft:moss_block
fill ~-46 ~1 ~-15 ~-46 ~3 ~-15 minecraft:stone
setblock ~-46 ~3 ~-15 minecraft:moss_block
fill ~-46 ~1 ~-14 ~-46 ~3 ~-14 minecraft:mossy_cobblestone
setblock ~-46 ~3 ~-14 minecraft:grass_block
fill ~-46 ~1 ~-13 ~-46 ~2 ~-13 minecraft:stone
setblock ~-46 ~2 ~-13 minecraft:moss_block
fill ~-46 ~1 ~-12 ~-46 ~2 ~-12 minecraft:stone
setblock ~-46 ~2 ~-12 minecraft:moss_block
fill ~-46 ~1 ~-11 ~-46 ~1 ~-11 minecraft:stone
setblock ~-46 ~1 ~-11 minecraft:moss_block
fill ~-46 ~1 ~-10 ~-46 ~1 ~-10 minecraft:stone
setblock ~-46 ~1 ~-10 minecraft:grass_block
fill ~-45 ~1 ~-27 ~-45 ~1 ~-27 minecraft:stone
setblock ~-45 ~1 ~-27 minecraft:grass_block
fill ~-45 ~1 ~-26 ~-45 ~1 ~-26 minecraft:stone
setblock ~-45 ~1 ~-26 minecraft:moss_block
fill ~-45 ~1 ~-25 ~-45 ~2 ~-25 minecraft:mossy_cobblestone
setblock ~-45 ~2 ~-25 minecraft:moss_block
fill ~-45 ~1 ~-24 ~-45 ~2 ~-24 minecraft:stone
setblock ~-45 ~2 ~-24 minecraft:moss_block
fill ~-45 ~1 ~-23 ~-45 ~3 ~-23 minecraft:stone
setblock ~-45 ~3 ~-23 minecraft:grass_block
fill ~-45 ~1 ~-22 ~-45 ~3 ~-22 minecraft:stone
setblock ~-45 ~3 ~-22 minecraft:moss_block
fill ~-45 ~1 ~-21 ~-45 ~4 ~-21 minecraft:stone
setblock ~-45 ~4 ~-21 minecraft:moss_block
fill ~-45 ~1 ~-20 ~-45 ~4 ~-20 minecraft:mossy_cobblestone
setblock ~-45 ~4 ~-20 minecraft:moss_block
fill ~-45 ~1 ~-19 ~-45 ~4 ~-19 minecraft:stone
setblock ~-45 ~4 ~-19 minecraft:grass_block
fill ~-45 ~1 ~-18 ~-45 ~4 ~-18 minecraft:stone
setblock ~-45 ~4 ~-18 minecraft:moss_block
fill ~-45 ~1 ~-17 ~-45 ~4 ~-17 minecraft:stone
setblock ~-45 ~4 ~-17 minecraft:moss_block
fill ~-45 ~1 ~-16 ~-45 ~4 ~-16 minecraft:stone
setblock ~-45 ~4 ~-16 minecraft:moss_block
fill ~-45 ~1 ~-15 ~-45 ~4 ~-15 minecraft:mossy_cobblestone
setblock ~-45 ~4 ~-15 minecraft:grass_block
fill ~-45 ~1 ~-14 ~-45 ~3 ~-14 minecraft:stone
setblock ~-45 ~3 ~-14 minecraft:moss_block
fill ~-45 ~1 ~-13 ~-45 ~3 ~-13 minecraft:stone
setblock ~-45 ~3 ~-13 minecraft:moss_block
fill ~-45 ~1 ~-12 ~-45 ~2 ~-12 minecraft:stone
setblock ~-45 ~2 ~-12 minecraft:moss_block
fill ~-45 ~1 ~-11 ~-45 ~2 ~-11 minecraft:stone
setblock ~-45 ~2 ~-11 minecraft:grass_block
fill ~-45 ~1 ~-10 ~-45 ~1 ~-10 minecraft:mossy_cobblestone
setblock ~-45 ~1 ~-10 minecraft:moss_block
fill ~-45 ~1 ~-9 ~-45 ~1 ~-9 minecraft:stone
setblock ~-45 ~1 ~-9 minecraft:moss_block
fill ~-44 ~1 ~-28 ~-44 ~1 ~-28 minecraft:stone
setblock ~-44 ~1 ~-28 minecraft:grass_block
fill ~-44 ~1 ~-27 ~-44 ~1 ~-27 minecraft:stone
setblock ~-44 ~1 ~-27 minecraft:moss_block
fill ~-44 ~1 ~-26 ~-44 ~2 ~-26 minecraft:mossy_cobblestone
setblock ~-44 ~2 ~-26 minecraft:moss_block
fill ~-44 ~1 ~-25 ~-44 ~3 ~-25 minecraft:stone
setblock ~-44 ~3 ~-25 minecraft:moss_block
fill ~-44 ~1 ~-24 ~-44 ~3 ~-24 minecraft:stone
setblock ~-44 ~3 ~-24 minecraft:grass_block
fill ~-44 ~1 ~-23 ~-44 ~4 ~-23 minecraft:stone
setblock ~-44 ~4 ~-23 minecraft:moss_block
fill ~-44 ~1 ~-22 ~-44 ~4 ~-22 minecraft:stone
setblock ~-44 ~4 ~-22 minecraft:moss_block
fill ~-44 ~1 ~-21 ~-44 ~4 ~-21 minecraft:mossy_cobblestone
setblock ~-44 ~4 ~-21 minecraft:moss_block
fill ~-44 ~1 ~-20 ~-44 ~5 ~-20 minecraft:stone
setblock ~-44 ~5 ~-20 minecraft:grass_block
fill ~-44 ~1 ~-19 ~-44 ~5 ~-19 minecraft:stone
setblock ~-44 ~5 ~-19 minecraft:moss_block
fill ~-44 ~1 ~-18 ~-44 ~5 ~-18 minecraft:stone
setblock ~-44 ~5 ~-18 minecraft:moss_block
fill ~-44 ~1 ~-17 ~-44 ~5 ~-17 minecraft:stone
setblock ~-44 ~5 ~-17 minecraft:moss_block
fill ~-44 ~1 ~-16 ~-44 ~5 ~-16 minecraft:mossy_cobblestone
setblock ~-44 ~5 ~-16 minecraft:grass_block
fill ~-44 ~1 ~-15 ~-44 ~4 ~-15 minecraft:stone
setblock ~-44 ~4 ~-15 minecraft:moss_block
fill ~-44 ~1 ~-14 ~-44 ~4 ~-14 minecraft:stone
setblock ~-44 ~4 ~-14 minecraft:moss_block
fill ~-44 ~1 ~-13 ~-44 ~4 ~-13 minecraft:stone
setblock ~-44 ~4 ~-13 minecraft:moss_block
fill ~-44 ~1 ~-12 ~-44 ~3 ~-12 minecraft:stone
setblock ~-44 ~3 ~-12 minecraft:grass_block
fill ~-44 ~1 ~-11 ~-44 ~3 ~-11 minecraft:mossy_cobblestone
setblock ~-44 ~3 ~-11 minecraft:moss_block
fill ~-44 ~1 ~-10 ~-44 ~2 ~-10 minecraft:stone
setblock ~-44 ~2 ~-10 minecraft:moss_block
fill ~-44 ~1 ~-9 ~-44 ~1 ~-9 minecraft:stone
setblock ~-44 ~1 ~-9 minecraft:moss_block
fill ~-43 ~1 ~-28 ~-43 ~1 ~-28 minecraft:stone
setblock ~-43 ~1 ~-28 minecraft:moss_block
fill ~-43 ~1 ~-27 ~-43 ~2 ~-27 minecraft:mossy_cobblestone
setblock ~-43 ~2 ~-27 minecraft:moss_block
fill ~-43 ~1 ~-26 ~-43 ~2 ~-26 minecraft:stone
setblock ~-43 ~2 ~-26 minecraft:moss_block
fill ~-43 ~1 ~-25 ~-43 ~3 ~-25 minecraft:stone
setblock ~-43 ~3 ~-25 minecraft:grass_block
fill ~-43 ~1 ~-24 ~-43 ~4 ~-24 minecraft:stone
setblock ~-43 ~4 ~-24 minecraft:moss_block
fill ~-43 ~1 ~-23 ~-43 ~4 ~-23 minecraft:stone
setblock ~-43 ~4 ~-23 minecraft:moss_block
fill ~-43 ~1 ~-22 ~-43 ~5 ~-22 minecraft:mossy_cobblestone
setblock ~-43 ~5 ~-22 minecraft:moss_block
fill ~-43 ~1 ~-21 ~-43 ~5 ~-21 minecraft:stone
setblock ~-43 ~5 ~-21 minecraft:grass_block
fill ~-43 ~1 ~-20 ~-43 ~5 ~-20 minecraft:stone
setblock ~-43 ~5 ~-20 minecraft:moss_block
fill ~-43 ~1 ~-19 ~-43 ~6 ~-19 minecraft:stone
setblock ~-43 ~6 ~-19 minecraft:moss_block
fill ~-43 ~1 ~-18 ~-43 ~6 ~-18 minecraft:stone
setblock ~-43 ~6 ~-18 minecraft:moss_block
fill ~-43 ~1 ~-17 ~-43 ~6 ~-17 minecraft:mossy_cobblestone
setblock ~-43 ~6 ~-17 minecraft:grass_block
fill ~-43 ~1 ~-16 ~-43 ~5 ~-16 minecraft:stone
setblock ~-43 ~5 ~-16 minecraft:moss_block
fill ~-43 ~1 ~-15 ~-43 ~5 ~-15 minecraft:stone
setblock ~-43 ~5 ~-15 minecraft:moss_block
fill ~-43 ~1 ~-14 ~-43 ~5 ~-14 minecraft:stone
setblock ~-43 ~5 ~-14 minecraft:moss_block
fill ~-43 ~1 ~-13 ~-43 ~4 ~-13 minecraft:stone
setblock ~-43 ~4 ~-13 minecraft:grass_block
fill ~-43 ~1 ~-12 ~-43 ~4 ~-12 minecraft:mossy_cobblestone
setblock ~-43 ~4 ~-12 minecraft:moss_block
fill ~-43 ~1 ~-11 ~-43 ~3 ~-11 minecraft:stone
setblock ~-43 ~3 ~-11 minecraft:moss_block
fill ~-43 ~1 ~-10 ~-43 ~2 ~-10 minecraft:stone
setblock ~-43 ~2 ~-10 minecraft:moss_block
fill ~-43 ~1 ~-9 ~-43 ~2 ~-9 minecraft:stone
setblock ~-43 ~2 ~-9 minecraft:grass_block
fill ~-42 ~1 ~-29 ~-42 ~1 ~-29 minecraft:stone
setblock ~-42 ~1 ~-29 minecraft:moss_block
fill ~-42 ~1 ~-28 ~-42 ~1 ~-28 minecraft:mossy_cobblestone
setblock ~-42 ~1 ~-28 minecraft:moss_block
fill ~-42 ~1 ~-27 ~-42 ~2 ~-27 minecraft:stone
setblock ~-42 ~2 ~-27 minecraft:moss_block
fill ~-42 ~1 ~-26 ~-42 ~3 ~-26 minecraft:stone
setblock ~-42 ~3 ~-26 minecraft:grass_block
fill ~-42 ~1 ~-25 ~-42 ~4 ~-25 minecraft:stone
setblock ~-42 ~4 ~-25 minecraft:moss_block
fill ~-42 ~1 ~-24 ~-42 ~4 ~-24 minecraft:stone
setblock ~-42 ~4 ~-24 minecraft:moss_block
fill ~-42 ~1 ~-23 ~-42 ~5 ~-23 minecraft:mossy_cobblestone
setblock ~-42 ~5 ~-23 minecraft:moss_block
fill ~-42 ~1 ~-22 ~-42 ~5 ~-22 minecraft:stone
setblock ~-42 ~5 ~-22 minecraft:grass_block
fill ~-42 ~1 ~-21 ~-42 ~6 ~-21 minecraft:stone
setblock ~-42 ~6 ~-21 minecraft:moss_block
fill ~-42 ~1 ~-20 ~-42 ~6 ~-20 minecraft:stone
setblock ~-42 ~6 ~-20 minecraft:moss_block
fill ~-42 ~1 ~-19 ~-42 ~6 ~-19 minecraft:stone
setblock ~-42 ~6 ~-19 minecraft:moss_block
fill ~-42 ~1 ~-18 ~-42 ~6 ~-18 minecraft:mossy_cobblestone
setblock ~-42 ~6 ~-18 minecraft:grass_block
fill ~-42 ~1 ~-17 ~-42 ~6 ~-17 minecraft:stone
setblock ~-42 ~6 ~-17 minecraft:moss_block
fill ~-42 ~1 ~-16 ~-42 ~6 ~-16 minecraft:stone
setblock ~-42 ~6 ~-16 minecraft:moss_block
fill ~-42 ~1 ~-15 ~-42 ~6 ~-15 minecraft:stone
setblock ~-42 ~6 ~-15 minecraft:moss_block
fill ~-42 ~1 ~-14 ~-42 ~5 ~-14 minecraft:stone
setblock ~-42 ~5 ~-14 minecraft:grass_block
fill ~-42 ~1 ~-13 ~-42 ~5 ~-13 minecraft:mossy_cobblestone
setblock ~-42 ~5 ~-13 minecraft:moss_block
fill ~-42 ~1 ~-12 ~-42 ~4 ~-12 minecraft:stone
setblock ~-42 ~4 ~-12 minecraft:moss_block
fill ~-42 ~1 ~-11 ~-42 ~4 ~-11 minecraft:stone
setblock ~-42 ~4 ~-11 minecraft:moss_block
fill ~-42 ~1 ~-10 ~-42 ~3 ~-10 minecraft:stone
setblock ~-42 ~3 ~-10 minecraft:grass_block
fill ~-42 ~1 ~-9 ~-42 ~2 ~-9 minecraft:stone
setblock ~-42 ~2 ~-9 minecraft:moss_block
fill ~-41 ~1 ~-29 ~-41 ~1 ~-29 minecraft:mossy_cobblestone
setblock ~-41 ~1 ~-29 minecraft:moss_block
fill ~-41 ~1 ~-28 ~-41 ~2 ~-28 minecraft:stone
setblock ~-41 ~2 ~-28 minecraft:moss_block
fill ~-41 ~1 ~-27 ~-41 ~3 ~-27 minecraft:stone
setblock ~-41 ~3 ~-27 minecraft:grass_block
fill ~-41 ~1 ~-26 ~-41 ~3 ~-26 minecraft:stone
setblock ~-41 ~3 ~-26 minecraft:moss_block
fill ~-41 ~1 ~-25 ~-41 ~4 ~-25 minecraft:stone
setblock ~-41 ~4 ~-25 minecraft:moss_block
fill ~-41 ~1 ~-24 ~-41 ~5 ~-24 minecraft:mossy_cobblestone
setblock ~-41 ~5 ~-24 minecraft:moss_block
fill ~-41 ~1 ~-23 ~-41 ~5 ~-23 minecraft:stone
setblock ~-41 ~5 ~-23 minecraft:grass_block
fill ~-41 ~1 ~-22 ~-41 ~6 ~-22 minecraft:stone
setblock ~-41 ~6 ~-22 minecraft:moss_block
fill ~-41 ~1 ~-21 ~-41 ~6 ~-21 minecraft:stone
setblock ~-41 ~6 ~-21 minecraft:moss_block
fill ~-41 ~1 ~-20 ~-41 ~6 ~-20 minecraft:stone
setblock ~-41 ~6 ~-20 minecraft:moss_block
fill ~-41 ~1 ~-19 ~-41 ~6 ~-19 minecraft:mossy_cobblestone
setblock ~-41 ~6 ~-19 minecraft:grass_block
fill ~-41 ~1 ~-18 ~-41 ~6 ~-18 minecraft:stone
setblock ~-41 ~6 ~-18 minecraft:moss_block
fill ~-41 ~1 ~-17 ~-41 ~6 ~-17 minecraft:stone
setblock ~-41 ~6 ~-17 minecraft:moss_block
fill ~-41 ~1 ~-16 ~-41 ~6 ~-16 minecraft:stone
setblock ~-41 ~6 ~-16 minecraft:moss_block
fill ~-41 ~1 ~-15 ~-41 ~6 ~-15 minecraft:stone
setblock ~-41 ~6 ~-15 minecraft:grass_block
fill ~-41 ~1 ~-14 ~-41 ~6 ~-14 minecraft:mossy_cobblestone
setblock ~-41 ~6 ~-14 minecraft:moss_block
fill ~-41 ~1 ~-13 ~-41 ~5 ~-13 minecraft:stone
setblock ~-41 ~5 ~-13 minecraft:moss_block
fill ~-41 ~1 ~-12 ~-41 ~5 ~-12 minecraft:stone
setblock ~-41 ~5 ~-12 minecraft:moss_block
fill ~-41 ~1 ~-11 ~-41 ~4 ~-11 minecraft:stone
setblock ~-41 ~4 ~-11 minecraft:grass_block
fill ~-41 ~1 ~-10 ~-41 ~3 ~-10 minecraft:stone
setblock ~-41 ~3 ~-10 minecraft:moss_block
fill ~-41 ~1 ~-9 ~-41 ~3 ~-9 minecraft:mossy_cobblestone
setblock ~-41 ~3 ~-9 minecraft:moss_block
fill ~-40 ~1 ~-29 ~-40 ~1 ~-29 minecraft:stone
setblock ~-40 ~1 ~-29 minecraft:moss_block
fill ~-40 ~1 ~-28 ~-40 ~2 ~-28 minecraft:stone
setblock ~-40 ~2 ~-28 minecraft:grass_block
fill ~-40 ~1 ~-27 ~-40 ~3 ~-27 minecraft:stone
setblock ~-40 ~3 ~-27 minecraft:moss_block
fill ~-40 ~1 ~-26 ~-40 ~4 ~-26 minecraft:stone
setblock ~-40 ~4 ~-26 minecraft:moss_block
fill ~-40 ~1 ~-25 ~-40 ~4 ~-25 minecraft:mossy_cobblestone
setblock ~-40 ~4 ~-25 minecraft:moss_block
fill ~-40 ~1 ~-24 ~-40 ~5 ~-24 minecraft:stone
setblock ~-40 ~5 ~-24 minecraft:grass_block
fill ~-40 ~1 ~-23 ~-40 ~6 ~-23 minecraft:stone
setblock ~-40 ~6 ~-23 minecraft:moss_block
fill ~-40 ~1 ~-22 ~-40 ~6 ~-22 minecraft:stone
setblock ~-40 ~6 ~-22 minecraft:moss_block
fill ~-40 ~1 ~-21 ~-40 ~6 ~-21 minecraft:stone
setblock ~-40 ~6 ~-21 minecraft:moss_block
fill ~-40 ~1 ~-20 ~-40 ~7 ~-20 minecraft:mossy_cobblestone
setblock ~-40 ~7 ~-20 minecraft:grass_block
fill ~-40 ~1 ~-19 ~-40 ~7 ~-19 minecraft:stone
setblock ~-40 ~7 ~-19 minecraft:moss_block
fill ~-40 ~1 ~-18 ~-40 ~7 ~-18 minecraft:stone
setblock ~-40 ~7 ~-18 minecraft:moss_block
fill ~-40 ~1 ~-17 ~-40 ~7 ~-17 minecraft:stone
setblock ~-40 ~7 ~-17 minecraft:moss_block
fill ~-40 ~1 ~-16 ~-40 ~7 ~-16 minecraft:stone
setblock ~-40 ~7 ~-16 minecraft:grass_block
fill ~-40 ~1 ~-15 ~-40 ~6 ~-15 minecraft:mossy_cobblestone
setblock ~-40 ~6 ~-15 minecraft:moss_block
fill ~-40 ~1 ~-14 ~-40 ~6 ~-14 minecraft:stone
setblock ~-40 ~6 ~-14 minecraft:moss_block
fill ~-40 ~1 ~-13 ~-40 ~6 ~-13 minecraft:stone
setblock ~-40 ~6 ~-13 minecraft:moss_block
fill ~-40 ~1 ~-12 ~-40 ~5 ~-12 minecraft:stone
setblock ~-40 ~5 ~-12 minecraft:grass_block
fill ~-40 ~1 ~-11 ~-40 ~4 ~-11 minecraft:stone
setblock ~-40 ~4 ~-11 minecraft:moss_block
fill ~-40 ~1 ~-10 ~-40 ~4 ~-10 minecraft:mossy_cobblestone
setblock ~-40 ~4 ~-10 minecraft:moss_block
fill ~-40 ~1 ~-9 ~-40 ~3 ~-9 minecraft:stone
setblock ~-40 ~3 ~-9 minecraft:moss_block
fill ~-39 ~1 ~-29 ~-39 ~1 ~-29 minecraft:stone
setblock ~-39 ~1 ~-29 minecraft:grass_block
fill ~-39 ~1 ~-28 ~-39 ~2 ~-28 minecraft:stone
setblock ~-39 ~2 ~-28 minecraft:moss_block
fill ~-39 ~1 ~-27 ~-39 ~3 ~-27 minecraft:stone
setblock ~-39 ~3 ~-27 minecraft:moss_block
fill ~-39 ~1 ~-26 ~-39 ~4 ~-26 minecraft:mossy_cobblestone
setblock ~-39 ~4 ~-26 minecraft:moss_block
fill ~-39 ~1 ~-25 ~-39 ~5 ~-25 minecraft:stone
setblock ~-39 ~5 ~-25 minecraft:grass_block
fill ~-39 ~1 ~-24 ~-39 ~5 ~-24 minecraft:stone
setblock ~-39 ~5 ~-24 minecraft:moss_block
fill ~-39 ~1 ~-23 ~-39 ~6 ~-23 minecraft:stone
setblock ~-39 ~6 ~-23 minecraft:moss_block
fill ~-39 ~1 ~-22 ~-39 ~6 ~-22 minecraft:stone
setblock ~-39 ~6 ~-22 minecraft:moss_block
fill ~-39 ~1 ~-21 ~-39 ~7 ~-21 minecraft:mossy_cobblestone
setblock ~-39 ~7 ~-21 minecraft:grass_block
fill ~-39 ~1 ~-20 ~-39 ~7 ~-20 minecraft:stone
setblock ~-39 ~7 ~-20 minecraft:moss_block
fill ~-39 ~1 ~-19 ~-39 ~7 ~-19 minecraft:stone
setblock ~-39 ~7 ~-19 minecraft:moss_block
fill ~-39 ~1 ~-18 ~-39 ~7 ~-18 minecraft:stone
setblock ~-39 ~7 ~-18 minecraft:moss_block
fill ~-39 ~1 ~-17 ~-39 ~7 ~-17 minecraft:stone
setblock ~-39 ~7 ~-17 minecraft:grass_block
fill ~-39 ~1 ~-16 ~-39 ~7 ~-16 minecraft:mossy_cobblestone
setblock ~-39 ~7 ~-16 minecraft:moss_block
fill ~-39 ~1 ~-15 ~-39 ~7 ~-15 minecraft:stone
setblock ~-39 ~7 ~-15 minecraft:moss_block
fill ~-39 ~1 ~-14 ~-39 ~6 ~-14 minecraft:stone
setblock ~-39 ~6 ~-14 minecraft:moss_block
fill ~-39 ~1 ~-13 ~-39 ~6 ~-13 minecraft:stone
setblock ~-39 ~6 ~-13 minecraft:grass_block
fill ~-39 ~1 ~-12 ~-39 ~5 ~-12 minecraft:stone
setblock ~-39 ~5 ~-12 minecraft:moss_block
fill ~-39 ~1 ~-11 ~-39 ~5 ~-11 minecraft:mossy_cobblestone
setblock ~-39 ~5 ~-11 minecraft:moss_block
fill ~-39 ~1 ~-10 ~-39 ~4 ~-10 minecraft:stone
setblock ~-39 ~4 ~-10 minecraft:moss_block
fill ~-39 ~1 ~-9 ~-39 ~3 ~-9 minecraft:stone
setblock ~-39 ~3 ~-9 minecraft:grass_block
fill ~-38 ~1 ~-29 ~-38 ~1 ~-29 minecraft:stone
setblock ~-38 ~1 ~-29 minecraft:moss_block
fill ~-38 ~1 ~-28 ~-38 ~2 ~-28 minecraft:stone
setblock ~-38 ~2 ~-28 minecraft:moss_block
fill ~-38 ~1 ~-27 ~-38 ~3 ~-27 minecraft:mossy_cobblestone
setblock ~-38 ~3 ~-27 minecraft:moss_block
fill ~-38 ~1 ~-26 ~-38 ~4 ~-26 minecraft:stone
setblock ~-38 ~4 ~-26 minecraft:grass_block
fill ~-38 ~1 ~-25 ~-38 ~5 ~-25 minecraft:stone
setblock ~-38 ~5 ~-25 minecraft:moss_block
fill ~-38 ~1 ~-24 ~-38 ~5 ~-24 minecraft:stone
setblock ~-38 ~5 ~-24 minecraft:moss_block
fill ~-38 ~1 ~-23 ~-38 ~6 ~-23 minecraft:stone
setblock ~-38 ~6 ~-23 minecraft:moss_block
fill ~-38 ~1 ~-22 ~-38 ~6 ~-22 minecraft:mossy_cobblestone
setblock ~-38 ~6 ~-22 minecraft:grass_block
fill ~-38 ~1 ~-21 ~-38 ~7 ~-21 minecraft:stone
setblock ~-38 ~7 ~-21 minecraft:moss_block
fill ~-38 ~1 ~-20 ~-38 ~7 ~-20 minecraft:stone
setblock ~-38 ~7 ~-20 minecraft:moss_block
fill ~-38 ~1 ~-19 ~-38 ~7 ~-19 minecraft:stone
setblock ~-38 ~7 ~-19 minecraft:moss_block
fill ~-38 ~1 ~-18 ~-38 ~7 ~-18 minecraft:stone
setblock ~-38 ~7 ~-18 minecraft:grass_block
fill ~-38 ~1 ~-17 ~-38 ~7 ~-17 minecraft:mossy_cobblestone
setblock ~-38 ~7 ~-17 minecraft:moss_block
fill ~-38 ~1 ~-16 ~-38 ~7 ~-16 minecraft:stone
setblock ~-38 ~7 ~-16 minecraft:moss_block
fill ~-38 ~1 ~-15 ~-38 ~7 ~-15 minecraft:stone
setblock ~-38 ~7 ~-15 minecraft:moss_block
fill ~-38 ~1 ~-14 ~-38 ~6 ~-14 minecraft:stone
setblock ~-38 ~6 ~-14 minecraft:grass_block
fill ~-38 ~1 ~-13 ~-38 ~6 ~-13 minecraft:stone
setblock ~-38 ~6 ~-13 minecraft:moss_block
fill ~-38 ~1 ~-12 ~-38 ~5 ~-12 minecraft:mossy_cobblestone
setblock ~-38 ~5 ~-12 minecraft:moss_block
fill ~-38 ~1 ~-11 ~-38 ~5 ~-11 minecraft:stone
setblock ~-38 ~5 ~-11 minecraft:moss_block
fill ~-38 ~1 ~-10 ~-38 ~4 ~-10 minecraft:stone
setblock ~-38 ~4 ~-10 minecraft:grass_block
fill ~-38 ~1 ~-9 ~-38 ~3 ~-9 minecraft:stone
setblock ~-38 ~3 ~-9 minecraft:moss_block
fill ~-37 ~1 ~-29 ~-37 ~1 ~-29 minecraft:stone
setblock ~-37 ~1 ~-29 minecraft:moss_block
fill ~-37 ~1 ~-28 ~-37 ~2 ~-28 minecraft:mossy_cobblestone
setblock ~-37 ~2 ~-28 minecraft:moss_block
fill ~-37 ~1 ~-27 ~-37 ~3 ~-27 minecraft:stone
setblock ~-37 ~3 ~-27 minecraft:grass_block
fill ~-37 ~1 ~-26 ~-37 ~4 ~-26 minecraft:stone
setblock ~-37 ~4 ~-26 minecraft:moss_block
fill ~-37 ~1 ~-25 ~-37 ~5 ~-25 minecraft:stone
setblock ~-37 ~5 ~-25 minecraft:moss_block
fill ~-37 ~1 ~-24 ~-37 ~5 ~-24 minecraft:stone
setblock ~-37 ~5 ~-24 minecraft:moss_block
fill ~-37 ~1 ~-23 ~-37 ~6 ~-23 minecraft:mossy_cobblestone
setblock ~-37 ~6 ~-23 minecraft:grass_block
fill ~-37 ~1 ~-22 ~-37 ~6 ~-22 minecraft:stone
setblock ~-37 ~6 ~-22 minecraft:moss_block
fill ~-37 ~1 ~-21 ~-37 ~7 ~-21 minecraft:stone
setblock ~-37 ~7 ~-21 minecraft:moss_block
fill ~-37 ~1 ~-20 ~-37 ~7 ~-20 minecraft:stone
setblock ~-37 ~7 ~-20 minecraft:moss_block
fill ~-37 ~1 ~-19 ~-37 ~7 ~-19 minecraft:stone
setblock ~-37 ~7 ~-19 minecraft:grass_block
fill ~-37 ~1 ~-18 ~-37 ~7 ~-18 minecraft:mossy_cobblestone
setblock ~-37 ~7 ~-18 minecraft:moss_block
fill ~-37 ~1 ~-17 ~-37 ~7 ~-17 minecraft:stone
setblock ~-37 ~7 ~-17 minecraft:moss_block
fill ~-37 ~1 ~-16 ~-37 ~7 ~-16 minecraft:stone
setblock ~-37 ~7 ~-16 minecraft:moss_block
fill ~-37 ~1 ~-15 ~-37 ~7 ~-15 minecraft:stone
setblock ~-37 ~7 ~-15 minecraft:grass_block
fill ~-37 ~1 ~-14 ~-37 ~6 ~-14 minecraft:stone
setblock ~-37 ~6 ~-14 minecraft:moss_block
fill ~-37 ~1 ~-13 ~-37 ~6 ~-13 minecraft:mossy_cobblestone
setblock ~-37 ~6 ~-13 minecraft:moss_block
fill ~-37 ~1 ~-12 ~-37 ~5 ~-12 minecraft:stone
setblock ~-37 ~5 ~-12 minecraft:moss_block
fill ~-37 ~1 ~-11 ~-37 ~5 ~-11 minecraft:stone
setblock ~-37 ~5 ~-11 minecraft:grass_block
fill ~-37 ~1 ~-10 ~-37 ~4 ~-10 minecraft:stone
setblock ~-37 ~4 ~-10 minecraft:moss_block
fill ~-37 ~1 ~-9 ~-37 ~3 ~-9 minecraft:stone
setblock ~-37 ~3 ~-9 minecraft:moss_block
fill ~-36 ~1 ~-29 ~-36 ~1 ~-29 minecraft:mossy_cobblestone
setblock ~-36 ~1 ~-29 minecraft:moss_block
fill ~-36 ~1 ~-28 ~-36 ~2 ~-28 minecraft:stone
setblock ~-36 ~2 ~-28 minecraft:grass_block
fill ~-36 ~1 ~-27 ~-36 ~3 ~-27 minecraft:stone
setblock ~-36 ~3 ~-27 minecraft:moss_block
fill ~-36 ~1 ~-26 ~-36 ~4 ~-26 minecraft:stone
setblock ~-36 ~4 ~-26 minecraft:moss_block
fill ~-36 ~1 ~-25 ~-36 ~4 ~-25 minecraft:stone
setblock ~-36 ~4 ~-25 minecraft:moss_block
fill ~-36 ~1 ~-24 ~-36 ~5 ~-24 minecraft:mossy_cobblestone
setblock ~-36 ~5 ~-24 minecraft:grass_block
fill ~-36 ~1 ~-23 ~-36 ~6 ~-23 minecraft:stone
setblock ~-36 ~6 ~-23 minecraft:moss_block
fill ~-36 ~1 ~-22 ~-36 ~6 ~-22 minecraft:stone
setblock ~-36 ~6 ~-22 minecraft:moss_block
fill ~-36 ~1 ~-21 ~-36 ~6 ~-21 minecraft:stone
setblock ~-36 ~6 ~-21 minecraft:moss_block
fill ~-36 ~1 ~-20 ~-36 ~7 ~-20 minecraft:stone
setblock ~-36 ~7 ~-20 minecraft:grass_block
fill ~-36 ~1 ~-19 ~-36 ~7 ~-19 minecraft:mossy_cobblestone
setblock ~-36 ~7 ~-19 minecraft:moss_block
fill ~-36 ~1 ~-18 ~-36 ~7 ~-18 minecraft:stone
setblock ~-36 ~7 ~-18 minecraft:moss_block
fill ~-36 ~1 ~-17 ~-36 ~7 ~-17 minecraft:stone
setblock ~-36 ~7 ~-17 minecraft:moss_block
fill ~-36 ~1 ~-16 ~-36 ~7 ~-16 minecraft:stone
setblock ~-36 ~7 ~-16 minecraft:grass_block
fill ~-36 ~1 ~-15 ~-36 ~6 ~-15 minecraft:stone
setblock ~-36 ~6 ~-15 minecraft:moss_block
fill ~-36 ~1 ~-14 ~-36 ~6 ~-14 minecraft:mossy_cobblestone
setblock ~-36 ~6 ~-14 minecraft:moss_block
fill ~-36 ~1 ~-13 ~-36 ~6 ~-13 minecraft:stone
setblock ~-36 ~6 ~-13 minecraft:moss_block
fill ~-36 ~1 ~-12 ~-36 ~5 ~-12 minecraft:stone
setblock ~-36 ~5 ~-12 minecraft:grass_block
fill ~-36 ~1 ~-11 ~-36 ~4 ~-11 minecraft:stone
setblock ~-36 ~4 ~-11 minecraft:moss_block
fill ~-36 ~1 ~-10 ~-36 ~4 ~-10 minecraft:stone
setblock ~-36 ~4 ~-10 minecraft:moss_block
fill ~-36 ~1 ~-9 ~-36 ~3 ~-9 minecraft:mossy_cobblestone
setblock ~-36 ~3 ~-9 minecraft:moss_block
fill ~-35 ~1 ~-29 ~-35 ~1 ~-29 minecraft:stone
setblock ~-35 ~1 ~-29 minecraft:grass_block
fill ~-35 ~1 ~-28 ~-35 ~2 ~-28 minecraft:stone
setblock ~-35 ~2 ~-28 minecraft:moss_block
fill ~-35 ~1 ~-27 ~-35 ~3 ~-27 minecraft:stone
setblock ~-35 ~3 ~-27 minecraft:moss_block
fill ~-35 ~1 ~-26 ~-35 ~3 ~-26 minecraft:stone
setblock ~-35 ~3 ~-26 minecraft:moss_block
fill ~-35 ~1 ~-25 ~-35 ~4 ~-25 minecraft:mossy_cobblestone
setblock ~-35 ~4 ~-25 minecraft:grass_block
fill ~-35 ~1 ~-24 ~-35 ~5 ~-24 minecraft:stone
setblock ~-35 ~5 ~-24 minecraft:moss_block
fill ~-35 ~1 ~-23 ~-35 ~5 ~-23 minecraft:stone
setblock ~-35 ~5 ~-23 minecraft:moss_block
fill ~-35 ~1 ~-22 ~-35 ~6 ~-22 minecraft:stone
setblock ~-35 ~6 ~-22 minecraft:moss_block
fill ~-35 ~1 ~-21 ~-35 ~6 ~-21 minecraft:stone
setblock ~-35 ~6 ~-21 minecraft:grass_block
fill ~-35 ~1 ~-20 ~-35 ~6 ~-20 minecraft:mossy_cobblestone
setblock ~-35 ~6 ~-20 minecraft:moss_block
fill ~-35 ~1 ~-19 ~-35 ~6 ~-19 minecraft:stone
setblock ~-35 ~6 ~-19 minecraft:moss_block
fill ~-35 ~1 ~-18 ~-35 ~6 ~-18 minecraft:stone
setblock ~-35 ~6 ~-18 minecraft:moss_block
fill ~-35 ~1 ~-17 ~-35 ~6 ~-17 minecraft:stone
setblock ~-35 ~6 ~-17 minecraft:grass_block
fill ~-35 ~1 ~-16 ~-35 ~6 ~-16 minecraft:stone
setblock ~-35 ~6 ~-16 minecraft:moss_block
fill ~-35 ~1 ~-15 ~-35 ~6 ~-15 minecraft:mossy_cobblestone
setblock ~-35 ~6 ~-15 minecraft:moss_block
fill ~-35 ~1 ~-14 ~-35 ~6 ~-14 minecraft:stone
setblock ~-35 ~6 ~-14 minecraft:moss_block
fill ~-35 ~1 ~-13 ~-35 ~5 ~-13 minecraft:stone
setblock ~-35 ~5 ~-13 minecraft:grass_block
fill ~-35 ~1 ~-12 ~-35 ~5 ~-12 minecraft:stone
setblock ~-35 ~5 ~-12 minecraft:moss_block
fill ~-35 ~1 ~-11 ~-35 ~4 ~-11 minecraft:stone
setblock ~-35 ~4 ~-11 minecraft:moss_block
fill ~-35 ~1 ~-10 ~-35 ~3 ~-10 minecraft:mossy_cobblestone
setblock ~-35 ~3 ~-10 minecraft:moss_block
fill ~-35 ~1 ~-9 ~-35 ~3 ~-9 minecraft:stone
setblock ~-35 ~3 ~-9 minecraft:grass_block
fill ~-34 ~1 ~-29 ~-34 ~1 ~-29 minecraft:stone
setblock ~-34 ~1 ~-29 minecraft:moss_block
fill ~-34 ~1 ~-28 ~-34 ~1 ~-28 minecraft:stone
setblock ~-34 ~1 ~-28 minecraft:moss_block
fill ~-34 ~1 ~-27 ~-34 ~2 ~-27 minecraft:stone
setblock ~-34 ~2 ~-27 minecraft:moss_block
fill ~-34 ~1 ~-26 ~-34 ~3 ~-26 minecraft:mossy_cobblestone
setblock ~-34 ~3 ~-26 minecraft:grass_block
fill ~-34 ~1 ~-25 ~-34 ~4 ~-25 minecraft:stone
setblock ~-34 ~4 ~-25 minecraft:moss_block
fill ~-34 ~1 ~-24 ~-34 ~4 ~-24 minecraft:stone
setblock ~-34 ~4 ~-24 minecraft:moss_block
fill ~-34 ~1 ~-23 ~-34 ~5 ~-23 minecraft:stone
setblock ~-34 ~5 ~-23 minecraft:moss_block
fill ~-34 ~1 ~-22 ~-34 ~5 ~-22 minecraft:stone
setblock ~-34 ~5 ~-22 minecraft:grass_block
fill ~-34 ~1 ~-21 ~-34 ~6 ~-21 minecraft:mossy_cobblestone
setblock ~-34 ~6 ~-21 minecraft:moss_block
fill ~-34 ~1 ~-20 ~-34 ~6 ~-20 minecraft:stone
setblock ~-34 ~6 ~-20 minecraft:moss_block
fill ~-34 ~1 ~-19 ~-34 ~6 ~-19 minecraft:stone
setblock ~-34 ~6 ~-19 minecraft:moss_block
fill ~-34 ~1 ~-18 ~-34 ~6 ~-18 minecraft:stone
setblock ~-34 ~6 ~-18 minecraft:grass_block
fill ~-34 ~1 ~-17 ~-34 ~6 ~-17 minecraft:stone
setblock ~-34 ~6 ~-17 minecraft:moss_block
fill ~-34 ~1 ~-16 ~-34 ~6 ~-16 minecraft:mossy_cobblestone
setblock ~-34 ~6 ~-16 minecraft:moss_block
fill ~-34 ~1 ~-15 ~-34 ~6 ~-15 minecraft:stone
setblock ~-34 ~6 ~-15 minecraft:moss_block
fill ~-34 ~1 ~-14 ~-34 ~5 ~-14 minecraft:stone
setblock ~-34 ~5 ~-14 minecraft:grass_block
fill ~-34 ~1 ~-13 ~-34 ~5 ~-13 minecraft:stone
setblock ~-34 ~5 ~-13 minecraft:moss_block
fill ~-34 ~1 ~-12 ~-34 ~4 ~-12 minecraft:stone
setblock ~-34 ~4 ~-12 minecraft:moss_block
fill ~-34 ~1 ~-11 ~-34 ~4 ~-11 minecraft:mossy_cobblestone
setblock ~-34 ~4 ~-11 minecraft:moss_block
fill ~-34 ~1 ~-10 ~-34 ~3 ~-10 minecraft:stone
setblock ~-34 ~3 ~-10 minecraft:grass_block
fill ~-34 ~1 ~-9 ~-34 ~2 ~-9 minecraft:stone
setblock ~-34 ~2 ~-9 minecraft:moss_block
fill ~-33 ~1 ~-28 ~-33 ~1 ~-28 minecraft:stone
setblock ~-33 ~1 ~-28 minecraft:moss_block
fill ~-33 ~1 ~-27 ~-33 ~2 ~-27 minecraft:mossy_cobblestone
setblock ~-33 ~2 ~-27 minecraft:grass_block
fill ~-33 ~1 ~-26 ~-33 ~2 ~-26 minecraft:stone
setblock ~-33 ~2 ~-26 minecraft:moss_block
fill ~-33 ~1 ~-25 ~-33 ~3 ~-25 minecraft:stone
setblock ~-33 ~3 ~-25 minecraft:moss_block
fill ~-33 ~1 ~-24 ~-33 ~4 ~-24 minecraft:stone
setblock ~-33 ~4 ~-24 minecraft:moss_block
fill ~-33 ~1 ~-23 ~-33 ~4 ~-23 minecraft:stone
setblock ~-33 ~4 ~-23 minecraft:grass_block
fill ~-33 ~1 ~-22 ~-33 ~5 ~-22 minecraft:mossy_cobblestone
setblock ~-33 ~5 ~-22 minecraft:moss_block
fill ~-33 ~1 ~-21 ~-33 ~5 ~-21 minecraft:stone
setblock ~-33 ~5 ~-21 minecraft:moss_block
fill ~-33 ~1 ~-20 ~-33 ~5 ~-20 minecraft:stone
setblock ~-33 ~5 ~-20 minecraft:moss_block
fill ~-33 ~1 ~-19 ~-33 ~6 ~-19 minecraft:stone
setblock ~-33 ~6 ~-19 minecraft:grass_block
fill ~-33 ~1 ~-18 ~-33 ~6 ~-18 minecraft:stone
setblock ~-33 ~6 ~-18 minecraft:moss_block
fill ~-33 ~1 ~-17 ~-33 ~6 ~-17 minecraft:mossy_cobblestone
setblock ~-33 ~6 ~-17 minecraft:moss_block
fill ~-33 ~1 ~-16 ~-33 ~5 ~-16 minecraft:stone
setblock ~-33 ~5 ~-16 minecraft:moss_block
fill ~-33 ~1 ~-15 ~-33 ~5 ~-15 minecraft:stone
setblock ~-33 ~5 ~-15 minecraft:grass_block
fill ~-33 ~1 ~-14 ~-33 ~5 ~-14 minecraft:stone
setblock ~-33 ~5 ~-14 minecraft:moss_block
fill ~-33 ~1 ~-13 ~-33 ~4 ~-13 minecraft:stone
setblock ~-33 ~4 ~-13 minecraft:moss_block
fill ~-33 ~1 ~-12 ~-33 ~4 ~-12 minecraft:mossy_cobblestone
setblock ~-33 ~4 ~-12 minecraft:moss_block
fill ~-33 ~1 ~-11 ~-33 ~3 ~-11 minecraft:stone
setblock ~-33 ~3 ~-11 minecraft:grass_block
fill ~-33 ~1 ~-10 ~-33 ~2 ~-10 minecraft:stone
setblock ~-33 ~2 ~-10 minecraft:moss_block
fill ~-33 ~1 ~-9 ~-33 ~2 ~-9 minecraft:stone
setblock ~-33 ~2 ~-9 minecraft:moss_block
fill ~-32 ~1 ~-28 ~-32 ~1 ~-28 minecraft:mossy_cobblestone
setblock ~-32 ~1 ~-28 minecraft:grass_block
fill ~-32 ~1 ~-27 ~-32 ~1 ~-27 minecraft:stone
setblock ~-32 ~1 ~-27 minecraft:moss_block
fill ~-32 ~1 ~-26 ~-32 ~2 ~-26 minecraft:stone
setblock ~-32 ~2 ~-26 minecraft:moss_block
fill ~-32 ~1 ~-25 ~-32 ~3 ~-25 minecraft:stone
setblock ~-32 ~3 ~-25 minecraft:moss_block
fill ~-32 ~1 ~-24 ~-32 ~3 ~-24 minecraft:stone
setblock ~-32 ~3 ~-24 minecraft:grass_block
fill ~-32 ~1 ~-23 ~-32 ~4 ~-23 minecraft:mossy_cobblestone
setblock ~-32 ~4 ~-23 minecraft:moss_block
fill ~-32 ~1 ~-22 ~-32 ~4 ~-22 minecraft:stone
setblock ~-32 ~4 ~-22 minecraft:moss_block
fill ~-32 ~1 ~-21 ~-32 ~4 ~-21 minecraft:stone
setblock ~-32 ~4 ~-21 minecraft:moss_block
fill ~-32 ~1 ~-20 ~-32 ~5 ~-20 minecraft:stone
setblock ~-32 ~5 ~-20 minecraft:grass_block
fill ~-32 ~1 ~-19 ~-32 ~5 ~-19 minecraft:stone
setblock ~-32 ~5 ~-19 minecraft:moss_block
fill ~-32 ~1 ~-18 ~-32 ~5 ~-18 minecraft:mossy_cobblestone
setblock ~-32 ~5 ~-18 minecraft:moss_block
fill ~-32 ~1 ~-17 ~-32 ~5 ~-17 minecraft:stone
setblock ~-32 ~5 ~-17 minecraft:moss_block
fill ~-32 ~1 ~-16 ~-32 ~5 ~-16 minecraft:stone
setblock ~-32 ~5 ~-16 minecraft:grass_block
fill ~-32 ~1 ~-15 ~-32 ~4 ~-15 minecraft:stone
setblock ~-32 ~4 ~-15 minecraft:moss_block
fill ~-32 ~1 ~-14 ~-32 ~4 ~-14 minecraft:stone
setblock ~-32 ~4 ~-14 minecraft:moss_block
fill ~-32 ~1 ~-13 ~-32 ~4 ~-13 minecraft:mossy_cobblestone
setblock ~-32 ~4 ~-13 minecraft:moss_block
fill ~-32 ~1 ~-12 ~-32 ~3 ~-12 minecraft:stone
setblock ~-32 ~3 ~-12 minecraft:grass_block
fill ~-32 ~1 ~-11 ~-32 ~3 ~-11 minecraft:stone
setblock ~-32 ~3 ~-11 minecraft:moss_block
fill ~-32 ~1 ~-10 ~-32 ~2 ~-10 minecraft:stone
setblock ~-32 ~2 ~-10 minecraft:moss_block
fill ~-32 ~1 ~-9 ~-32 ~1 ~-9 minecraft:stone
setblock ~-32 ~1 ~-9 minecraft:moss_block
fill ~-31 ~1 ~-27 ~-31 ~1 ~-27 minecraft:stone
setblock ~-31 ~1 ~-27 minecraft:moss_block
fill ~-31 ~1 ~-26 ~-31 ~1 ~-26 minecraft:stone
setblock ~-31 ~1 ~-26 minecraft:moss_block
fill ~-31 ~1 ~-25 ~-31 ~2 ~-25 minecraft:stone
setblock ~-31 ~2 ~-25 minecraft:grass_block
fill ~-31 ~1 ~-24 ~-31 ~2 ~-24 minecraft:mossy_cobblestone
setblock ~-31 ~2 ~-24 minecraft:moss_block
fill ~-31 ~1 ~-23 ~-31 ~3 ~-23 minecraft:stone
setblock ~-31 ~3 ~-23 minecraft:moss_block
fill ~-31 ~1 ~-22 ~-31 ~3 ~-22 minecraft:stone
setblock ~-31 ~3 ~-22 minecraft:moss_block
fill ~-31 ~1 ~-21 ~-31 ~4 ~-21 minecraft:stone
setblock ~-31 ~4 ~-21 minecraft:grass_block
fill ~-31 ~1 ~-20 ~-31 ~4 ~-20 minecraft:stone
setblock ~-31 ~4 ~-20 minecraft:moss_block
fill ~-31 ~1 ~-19 ~-31 ~4 ~-19 minecraft:mossy_cobblestone
setblock ~-31 ~4 ~-19 minecraft:moss_block
fill ~-31 ~1 ~-18 ~-31 ~4 ~-18 minecraft:stone
setblock ~-31 ~4 ~-18 minecraft:moss_block
fill ~-31 ~1 ~-17 ~-31 ~4 ~-17 minecraft:stone
setblock ~-31 ~4 ~-17 minecraft:grass_block
fill ~-31 ~1 ~-16 ~-31 ~4 ~-16 minecraft:stone
setblock ~-31 ~4 ~-16 minecraft:moss_block
fill ~-31 ~1 ~-15 ~-31 ~4 ~-15 minecraft:stone
setblock ~-31 ~4 ~-15 minecraft:moss_block
fill ~-31 ~1 ~-14 ~-31 ~3 ~-14 minecraft:mossy_cobblestone
setblock ~-31 ~3 ~-14 minecraft:moss_block
fill ~-31 ~1 ~-13 ~-31 ~3 ~-13 minecraft:stone
setblock ~-31 ~3 ~-13 minecraft:grass_block
fill ~-31 ~1 ~-12 ~-31 ~2 ~-12 minecraft:stone
setblock ~-31 ~2 ~-12 minecraft:moss_block
fill ~-31 ~1 ~-11 ~-31 ~2 ~-11 minecraft:stone
setblock ~-31 ~2 ~-11 minecraft:moss_block
fill ~-31 ~1 ~-10 ~-31 ~1 ~-10 minecraft:stone
setblock ~-31 ~1 ~-10 minecraft:moss_block
fill ~-31 ~1 ~-9 ~-31 ~1 ~-9 minecraft:mossy_cobblestone
setblock ~-31 ~1 ~-9 minecraft:grass_block
fill ~-30 ~1 ~-26 ~-30 ~1 ~-26 minecraft:stone
setblock ~-30 ~1 ~-26 minecraft:grass_block
fill ~-30 ~1 ~-25 ~-30 ~1 ~-25 minecraft:mossy_cobblestone
setblock ~-30 ~1 ~-25 minecraft:moss_block
fill ~-30 ~1 ~-24 ~-30 ~2 ~-24 minecraft:stone
setblock ~-30 ~2 ~-24 minecraft:moss_block
fill ~-30 ~1 ~-23 ~-30 ~2 ~-23 minecraft:stone
setblock ~-30 ~2 ~-23 minecraft:moss_block
fill ~-30 ~1 ~-22 ~-30 ~3 ~-22 minecraft:stone
setblock ~-30 ~3 ~-22 minecraft:grass_block
fill ~-30 ~1 ~-21 ~-30 ~3 ~-21 minecraft:stone
setblock ~-30 ~3 ~-21 minecraft:moss_block
fill ~-30 ~1 ~-20 ~-30 ~3 ~-20 minecraft:mossy_cobblestone
setblock ~-30 ~3 ~-20 minecraft:moss_block
fill ~-30 ~1 ~-19 ~-30 ~3 ~-19 minecraft:stone
setblock ~-30 ~3 ~-19 minecraft:moss_block
fill ~-30 ~1 ~-18 ~-30 ~3 ~-18 minecraft:stone
setblock ~-30 ~3 ~-18 minecraft:grass_block
fill ~-30 ~1 ~-17 ~-30 ~3 ~-17 minecraft:stone
setblock ~-30 ~3 ~-17 minecraft:moss_block
fill ~-30 ~1 ~-16 ~-30 ~3 ~-16 minecraft:stone
setblock ~-30 ~3 ~-16 minecraft:moss_block
fill ~-30 ~1 ~-15 ~-30 ~3 ~-15 minecraft:mossy_cobblestone
setblock ~-30 ~3 ~-15 minecraft:moss_block
fill ~-30 ~1 ~-14 ~-30 ~3 ~-14 minecraft:stone
setblock ~-30 ~3 ~-14 minecraft:grass_block
fill ~-30 ~1 ~-13 ~-30 ~2 ~-13 minecraft:stone
setblock ~-30 ~2 ~-13 minecraft:moss_block
fill ~-30 ~1 ~-12 ~-30 ~2 ~-12 minecraft:stone
setblock ~-30 ~2 ~-12 minecraft:moss_block
fill ~-30 ~1 ~-11 ~-30 ~1 ~-11 minecraft:stone
setblock ~-30 ~1 ~-11 minecraft:moss_block
fill ~-30 ~1 ~-10 ~-30 ~1 ~-10 minecraft:mossy_cobblestone
setblock ~-30 ~1 ~-10 minecraft:grass_block
fill ~-29 ~1 ~-24 ~-29 ~1 ~-24 minecraft:stone
setblock ~-29 ~1 ~-24 minecraft:moss_block
fill ~-29 ~1 ~-23 ~-29 ~1 ~-23 minecraft:stone
setblock ~-29 ~1 ~-23 minecraft:grass_block
fill ~-29 ~1 ~-22 ~-29 ~2 ~-22 minecraft:stone
setblock ~-29 ~2 ~-22 minecraft:moss_block
fill ~-29 ~1 ~-21 ~-29 ~2 ~-21 minecraft:mossy_cobblestone
setblock ~-29 ~2 ~-21 minecraft:moss_block
fill ~-29 ~1 ~-20 ~-29 ~2 ~-20 minecraft:stone
setblock ~-29 ~2 ~-20 minecraft:moss_block
fill ~-29 ~1 ~-19 ~-29 ~2 ~-19 minecraft:stone
setblock ~-29 ~2 ~-19 minecraft:grass_block
fill ~-29 ~1 ~-18 ~-29 ~2 ~-18 minecraft:stone
setblock ~-29 ~2 ~-18 minecraft:moss_block
fill ~-29 ~1 ~-17 ~-29 ~2 ~-17 minecraft:stone
setblock ~-29 ~2 ~-17 minecraft:moss_block
fill ~-29 ~1 ~-16 ~-29 ~2 ~-16 minecraft:mossy_cobblestone
setblock ~-29 ~2 ~-16 minecraft:moss_block
fill ~-29 ~1 ~-15 ~-29 ~2 ~-15 minecraft:stone
setblock ~-29 ~2 ~-15 minecraft:grass_block
fill ~-29 ~1 ~-14 ~-29 ~2 ~-14 minecraft:stone
setblock ~-29 ~2 ~-14 minecraft:moss_block
fill ~-29 ~1 ~-13 ~-29 ~1 ~-13 minecraft:stone
setblock ~-29 ~1 ~-13 minecraft:moss_block
fill ~-29 ~1 ~-12 ~-29 ~1 ~-12 minecraft:stone
setblock ~-29 ~1 ~-12 minecraft:moss_block
fill ~-28 ~1 ~-22 ~-28 ~1 ~-22 minecraft:mossy_cobblestone
setblock ~-28 ~1 ~-22 minecraft:moss_block
fill ~-28 ~1 ~-21 ~-28 ~1 ~-21 minecraft:stone
setblock ~-28 ~1 ~-21 minecraft:moss_block
fill ~-28 ~1 ~-20 ~-28 ~1 ~-20 minecraft:stone
setblock ~-28 ~1 ~-20 minecraft:grass_block
fill ~-28 ~1 ~-19 ~-28 ~1 ~-19 minecraft:stone
setblock ~-28 ~1 ~-19 minecraft:moss_block
fill ~-28 ~1 ~-18 ~-28 ~1 ~-18 minecraft:stone
setblock ~-28 ~1 ~-18 minecraft:moss_block
fill ~-28 ~1 ~-17 ~-28 ~1 ~-17 minecraft:mossy_cobblestone
setblock ~-28 ~1 ~-17 minecraft:moss_block
fill ~-28 ~1 ~-16 ~-28 ~1 ~-16 minecraft:stone
setblock ~-28 ~1 ~-16 minecraft:grass_block
fill ~-28 ~1 ~-15 ~-28 ~1 ~-15 minecraft:stone
setblock ~-28 ~1 ~-15 minecraft:moss_block
fill ~-28 ~1 ~-14 ~-28 ~1 ~-14 minecraft:stone
setblock ~-28 ~1 ~-14 minecraft:moss_block
fill ~-43 ~5 ~-23 ~-43 ~8 ~-23 minecraft:spruce_log
fill ~-45 ~8 ~-24 ~-41 ~8 ~-22 minecraft:spruce_leaves[persistent=true]
fill ~-44 ~9 ~-24 ~-42 ~9 ~-22 minecraft:spruce_leaves[persistent=true]
fill ~-38 ~5 ~-26 ~-38 ~8 ~-26 minecraft:spruce_log
fill ~-40 ~8 ~-27 ~-36 ~8 ~-25 minecraft:spruce_leaves[persistent=true]
fill ~-39 ~9 ~-27 ~-37 ~9 ~-25 minecraft:spruce_leaves[persistent=true]
fill ~-34 ~7 ~-20 ~-34 ~10 ~-20 minecraft:spruce_log
fill ~-36 ~10 ~-21 ~-32 ~10 ~-19 minecraft:spruce_leaves[persistent=true]
fill ~-35 ~11 ~-21 ~-33 ~11 ~-19 minecraft:spruce_leaves[persistent=true]
fill ~-41 ~7 ~-16 ~-41 ~10 ~-16 minecraft:spruce_log
fill ~-43 ~10 ~-17 ~-39 ~10 ~-15 minecraft:spruce_leaves[persistent=true]
fill ~-42 ~11 ~-17 ~-40 ~11 ~-15 minecraft:spruce_leaves[persistent=true]
fill ~-36 ~7 ~-15 ~-36 ~10 ~-15 minecraft:spruce_log
fill ~-38 ~10 ~-16 ~-34 ~10 ~-14 minecraft:spruce_leaves[persistent=true]
fill ~-37 ~11 ~-16 ~-35 ~11 ~-14 minecraft:spruce_leaves[persistent=true]
fill ~-30 ~4 ~-19 ~-30 ~7 ~-19 minecraft:spruce_log
fill ~-32 ~7 ~-20 ~-28 ~7 ~-18 minecraft:spruce_leaves[persistent=true]
fill ~-31 ~8 ~-20 ~-29 ~8 ~-18 minecraft:spruce_leaves[persistent=true]
fill ~-35 ~0 ~6 ~-20 ~0 ~8 minecraft:gravel
setblock ~-35 ~1 ~5 minecraft:mossy_stone_bricks
setblock ~-35 ~2 ~5 minecraft:stone_brick_wall
setblock ~-35 ~3 ~5 minecraft:lantern
setblock ~-28 ~1 ~9 minecraft:mossy_stone_bricks
setblock ~-28 ~2 ~9 minecraft:stone_brick_wall
setblock ~-28 ~3 ~9 minecraft:lantern
setblock ~-20 ~1 ~9 minecraft:mossy_stone_bricks
setblock ~-20 ~2 ~9 minecraft:stone_brick_wall
setblock ~-20 ~3 ~9 minecraft:lantern
setblock ~-27 ~1 ~-12 minecraft:mossy_stone_bricks
setblock ~-27 ~2 ~-12 minecraft:stone_brick_wall
setblock ~-27 ~3 ~-12 minecraft:lantern
setblock ~-23 ~1 ~-12 minecraft:mossy_stone_bricks
setblock ~-23 ~2 ~-12 minecraft:stone_brick_wall
setblock ~-23 ~3 ~-12 minecraft:lantern
fill ~-21 ~0 ~9 ~-8 ~0 ~12 minecraft:spruce_planks
fill ~-21 ~1 ~9 ~-21 ~3 ~9 minecraft:stripped_spruce_log
fill ~-21 ~1 ~12 ~-21 ~3 ~12 minecraft:stripped_spruce_log
setblock ~-21 ~2 ~12 minecraft:lantern[hanging=true]
fill ~-17 ~1 ~9 ~-17 ~3 ~9 minecraft:stripped_spruce_log
fill ~-17 ~1 ~12 ~-17 ~3 ~12 minecraft:stripped_spruce_log
setblock ~-17 ~2 ~12 minecraft:lantern[hanging=true]
fill ~-13 ~1 ~9 ~-13 ~3 ~9 minecraft:stripped_spruce_log
fill ~-13 ~1 ~12 ~-13 ~3 ~12 minecraft:stripped_spruce_log
setblock ~-13 ~2 ~12 minecraft:lantern[hanging=true]
fill ~-8 ~1 ~9 ~-8 ~3 ~9 minecraft:stripped_spruce_log
fill ~-8 ~1 ~12 ~-8 ~3 ~12 minecraft:stripped_spruce_log
setblock ~-8 ~2 ~12 minecraft:lantern[hanging=true]
fill ~-22 ~4 ~8 ~-7 ~4 ~13 minecraft:deepslate_tiles
fill ~-22 ~4 ~8 ~-7 ~4 ~8 minecraft:deepslate_tile_stairs[facing=south]
fill ~-22 ~4 ~13 ~-7 ~4 ~13 minecraft:deepslate_tile_stairs[facing=north]
fill ~-22 ~5 ~10 ~-7 ~5 ~11 minecraft:deepslate_tile_slab[type=bottom]

fill ~-34 ~0 ~-12 ~-29 ~5 ~-8 minecraft:mossy_cobblestone
fill ~-30 ~0 ~-10 ~-29 ~6 ~-9 minecraft:air
fill ~-30 ~-2 ~-10 ~-24 ~-2 ~-9 minecraft:stone
fill ~-30 ~-1 ~-11 ~-24 ~0 ~-11 minecraft:mossy_stone_bricks
fill ~-30 ~-1 ~-8 ~-24 ~0 ~-8 minecraft:mossy_stone_bricks
fill ~-31 ~-1 ~-10 ~-31 ~6 ~-9 minecraft:mossy_cobblestone
fill ~-30 ~-1 ~-10 ~-24 ~-1 ~-9 minecraft:water
fill ~-30 ~0 ~-10 ~-24 ~0 ~-9 minecraft:air
fill ~-30 ~1 ~-11 ~-30 ~6 ~-11 minecraft:mossy_cobblestone
fill ~-30 ~1 ~-8 ~-30 ~6 ~-8 minecraft:mossy_cobblestone
fill ~-29 ~1 ~-10 ~-29 ~6 ~-9 minecraft:mossy_cobblestone
fill ~-30 ~1 ~-10 ~-30 ~5 ~-9 minecraft:water
fill ~-48 ~0 ~-40 ~-46 ~0 ~-38 minecraft:moss_block
setblock ~-48 ~1 ~-39 minecraft:azalea_leaves[persistent=true]
setblock ~-46 ~1 ~-39 minecraft:flowering_azalea_leaves[persistent=true]
setblock ~-47 ~1 ~-39 minecraft:mossy_stone_bricks
setblock ~-47 ~2 ~-39 minecraft:stone_brick_wall
setblock ~-47 ~3 ~-39 minecraft:lantern
fill ~-48 ~0 ~-27 ~-46 ~0 ~-25 minecraft:moss_block
setblock ~-48 ~1 ~-26 minecraft:azalea_leaves[persistent=true]
setblock ~-46 ~1 ~-26 minecraft:flowering_azalea_leaves[persistent=true]
setblock ~-47 ~1 ~-26 minecraft:mossy_stone_bricks
setblock ~-47 ~2 ~-26 minecraft:stone_brick_wall
setblock ~-47 ~3 ~-26 minecraft:lantern
fill ~-48 ~0 ~-14 ~-46 ~0 ~-12 minecraft:moss_block
setblock ~-48 ~1 ~-13 minecraft:azalea_leaves[persistent=true]
setblock ~-46 ~1 ~-13 minecraft:flowering_azalea_leaves[persistent=true]
setblock ~-47 ~1 ~-13 minecraft:mossy_stone_bricks
setblock ~-47 ~2 ~-13 minecraft:stone_brick_wall
setblock ~-47 ~3 ~-13 minecraft:lantern
fill ~-48 ~0 ~2 ~-46 ~0 ~4 minecraft:moss_block
setblock ~-48 ~1 ~3 minecraft:azalea_leaves[persistent=true]
setblock ~-46 ~1 ~3 minecraft:flowering_azalea_leaves[persistent=true]
setblock ~-47 ~1 ~3 minecraft:mossy_stone_bricks
setblock ~-47 ~2 ~3 minecraft:stone_brick_wall
setblock ~-47 ~3 ~3 minecraft:lantern
fill ~-48 ~0 ~16 ~-46 ~0 ~18 minecraft:moss_block
setblock ~-48 ~1 ~17 minecraft:azalea_leaves[persistent=true]
setblock ~-46 ~1 ~17 minecraft:flowering_azalea_leaves[persistent=true]
setblock ~-47 ~1 ~17 minecraft:mossy_stone_bricks
setblock ~-47 ~2 ~17 minecraft:stone_brick_wall
setblock ~-47 ~3 ~17 minecraft:lantern
fill ~-48 ~0 ~29 ~-46 ~0 ~31 minecraft:moss_block
setblock ~-48 ~1 ~30 minecraft:azalea_leaves[persistent=true]
setblock ~-46 ~1 ~30 minecraft:flowering_azalea_leaves[persistent=true]
setblock ~-47 ~1 ~30 minecraft:mossy_stone_bricks
setblock ~-47 ~2 ~30 minecraft:stone_brick_wall
setblock ~-47 ~3 ~30 minecraft:lantern
fill ~-48 ~0 ~41 ~-46 ~0 ~43 minecraft:moss_block
setblock ~-48 ~1 ~42 minecraft:azalea_leaves[persistent=true]
setblock ~-46 ~1 ~42 minecraft:flowering_azalea_leaves[persistent=true]
setblock ~-47 ~1 ~42 minecraft:mossy_stone_bricks
setblock ~-47 ~2 ~42 minecraft:stone_brick_wall
setblock ~-47 ~3 ~42 minecraft:lantern
fill ~46 ~0 ~-40 ~48 ~0 ~-38 minecraft:moss_block
setblock ~46 ~1 ~-39 minecraft:azalea_leaves[persistent=true]
setblock ~48 ~1 ~-39 minecraft:flowering_azalea_leaves[persistent=true]
setblock ~47 ~1 ~-39 minecraft:mossy_stone_bricks
setblock ~47 ~2 ~-39 minecraft:stone_brick_wall
setblock ~47 ~3 ~-39 minecraft:lantern
fill ~46 ~0 ~-27 ~48 ~0 ~-25 minecraft:moss_block
setblock ~46 ~1 ~-26 minecraft:azalea_leaves[persistent=true]
setblock ~48 ~1 ~-26 minecraft:flowering_azalea_leaves[persistent=true]
setblock ~47 ~1 ~-26 minecraft:mossy_stone_bricks
setblock ~47 ~2 ~-26 minecraft:stone_brick_wall
setblock ~47 ~3 ~-26 minecraft:lantern
fill ~46 ~0 ~-14 ~48 ~0 ~-12 minecraft:moss_block
setblock ~46 ~1 ~-13 minecraft:azalea_leaves[persistent=true]
setblock ~48 ~1 ~-13 minecraft:flowering_azalea_leaves[persistent=true]
setblock ~47 ~1 ~-13 minecraft:mossy_stone_bricks
setblock ~47 ~2 ~-13 minecraft:stone_brick_wall
setblock ~47 ~3 ~-13 minecraft:lantern
fill ~46 ~0 ~2 ~48 ~0 ~4 minecraft:moss_block
setblock ~46 ~1 ~3 minecraft:azalea_leaves[persistent=true]
setblock ~48 ~1 ~3 minecraft:flowering_azalea_leaves[persistent=true]
setblock ~47 ~1 ~3 minecraft:mossy_stone_bricks
setblock ~47 ~2 ~3 minecraft:stone_brick_wall
setblock ~47 ~3 ~3 minecraft:lantern
fill ~46 ~0 ~16 ~48 ~0 ~18 minecraft:moss_block
setblock ~46 ~1 ~17 minecraft:azalea_leaves[persistent=true]
setblock ~48 ~1 ~17 minecraft:flowering_azalea_leaves[persistent=true]
setblock ~47 ~1 ~17 minecraft:mossy_stone_bricks
setblock ~47 ~2 ~17 minecraft:stone_brick_wall
setblock ~47 ~3 ~17 minecraft:lantern
fill ~46 ~0 ~29 ~48 ~0 ~31 minecraft:moss_block
setblock ~46 ~1 ~30 minecraft:azalea_leaves[persistent=true]
setblock ~48 ~1 ~30 minecraft:flowering_azalea_leaves[persistent=true]
setblock ~47 ~1 ~30 minecraft:mossy_stone_bricks
setblock ~47 ~2 ~30 minecraft:stone_brick_wall
setblock ~47 ~3 ~30 minecraft:lantern
fill ~46 ~0 ~41 ~48 ~0 ~43 minecraft:moss_block
setblock ~46 ~1 ~42 minecraft:azalea_leaves[persistent=true]
setblock ~48 ~1 ~42 minecraft:flowering_azalea_leaves[persistent=true]
setblock ~47 ~1 ~42 minecraft:mossy_stone_bricks
setblock ~47 ~2 ~42 minecraft:stone_brick_wall
setblock ~47 ~3 ~42 minecraft:lantern
fill ~-34 ~0 ~-48 ~-32 ~0 ~-46 minecraft:moss_block
setblock ~-34 ~1 ~-47 minecraft:azalea_leaves[persistent=true]
setblock ~-32 ~1 ~-47 minecraft:flowering_azalea_leaves[persistent=true]
setblock ~-33 ~1 ~-47 minecraft:mossy_stone_bricks
setblock ~-33 ~2 ~-47 minecraft:stone_brick_wall
setblock ~-33 ~3 ~-47 minecraft:lantern
fill ~-19 ~0 ~-48 ~-17 ~0 ~-46 minecraft:moss_block
setblock ~-19 ~1 ~-47 minecraft:azalea_leaves[persistent=true]
setblock ~-17 ~1 ~-47 minecraft:flowering_azalea_leaves[persistent=true]
setblock ~-18 ~1 ~-47 minecraft:mossy_stone_bricks
setblock ~-18 ~2 ~-47 minecraft:stone_brick_wall
setblock ~-18 ~3 ~-47 minecraft:lantern
fill ~-4 ~0 ~-48 ~-2 ~0 ~-46 minecraft:moss_block
setblock ~-4 ~1 ~-47 minecraft:azalea_leaves[persistent=true]
setblock ~-2 ~1 ~-47 minecraft:flowering_azalea_leaves[persistent=true]
setblock ~-3 ~1 ~-47 minecraft:mossy_stone_bricks
setblock ~-3 ~2 ~-47 minecraft:stone_brick_wall
setblock ~-3 ~3 ~-47 minecraft:lantern
fill ~12 ~0 ~-48 ~14 ~0 ~-46 minecraft:moss_block
setblock ~12 ~1 ~-47 minecraft:azalea_leaves[persistent=true]
setblock ~14 ~1 ~-47 minecraft:flowering_azalea_leaves[persistent=true]
setblock ~13 ~1 ~-47 minecraft:mossy_stone_bricks
setblock ~13 ~2 ~-47 minecraft:stone_brick_wall
setblock ~13 ~3 ~-47 minecraft:lantern
fill ~28 ~0 ~-48 ~30 ~0 ~-46 minecraft:moss_block
setblock ~28 ~1 ~-47 minecraft:azalea_leaves[persistent=true]
setblock ~30 ~1 ~-47 minecraft:flowering_azalea_leaves[persistent=true]
setblock ~29 ~1 ~-47 minecraft:mossy_stone_bricks
setblock ~29 ~2 ~-47 minecraft:stone_brick_wall
setblock ~29 ~3 ~-47 minecraft:lantern
fill ~-34 ~0 ~46 ~-32 ~0 ~48 minecraft:moss_block
setblock ~-34 ~1 ~47 minecraft:azalea_leaves[persistent=true]
setblock ~-32 ~1 ~47 minecraft:flowering_azalea_leaves[persistent=true]
setblock ~-33 ~1 ~47 minecraft:mossy_stone_bricks
setblock ~-33 ~2 ~47 minecraft:stone_brick_wall
setblock ~-33 ~3 ~47 minecraft:lantern
fill ~-19 ~0 ~46 ~-17 ~0 ~48 minecraft:moss_block
setblock ~-19 ~1 ~47 minecraft:azalea_leaves[persistent=true]
setblock ~-17 ~1 ~47 minecraft:flowering_azalea_leaves[persistent=true]
setblock ~-18 ~1 ~47 minecraft:mossy_stone_bricks
setblock ~-18 ~2 ~47 minecraft:stone_brick_wall
setblock ~-18 ~3 ~47 minecraft:lantern
fill ~-4 ~0 ~46 ~-2 ~0 ~48 minecraft:moss_block
setblock ~-4 ~1 ~47 minecraft:azalea_leaves[persistent=true]
setblock ~-2 ~1 ~47 minecraft:flowering_azalea_leaves[persistent=true]
setblock ~-3 ~1 ~47 minecraft:mossy_stone_bricks
setblock ~-3 ~2 ~47 minecraft:stone_brick_wall
setblock ~-3 ~3 ~47 minecraft:lantern
fill ~12 ~0 ~46 ~14 ~0 ~48 minecraft:moss_block
setblock ~12 ~1 ~47 minecraft:azalea_leaves[persistent=true]
setblock ~14 ~1 ~47 minecraft:flowering_azalea_leaves[persistent=true]
setblock ~13 ~1 ~47 minecraft:mossy_stone_bricks
setblock ~13 ~2 ~47 minecraft:stone_brick_wall
setblock ~13 ~3 ~47 minecraft:lantern
fill ~28 ~0 ~46 ~30 ~0 ~48 minecraft:moss_block
setblock ~28 ~1 ~47 minecraft:azalea_leaves[persistent=true]
setblock ~30 ~1 ~47 minecraft:flowering_azalea_leaves[persistent=true]
setblock ~29 ~1 ~47 minecraft:mossy_stone_bricks
setblock ~29 ~2 ~47 minecraft:stone_brick_wall
setblock ~29 ~3 ~47 minecraft:lantern
fill ~-42 ~1 ~31 ~-42 ~4 ~31 minecraft:bamboo
fill ~-40 ~1 ~32 ~-40 ~4 ~32 minecraft:bamboo
fill ~-39 ~1 ~30 ~-39 ~3 ~30 minecraft:bamboo
fill ~39 ~1 ~-33 ~39 ~3 ~-33 minecraft:bamboo
fill ~41 ~1 ~-33 ~41 ~5 ~-33 minecraft:bamboo
fill ~40 ~1 ~-35 ~40 ~5 ~-35 minecraft:bamboo
fill ~-19 ~1 ~39 ~-19 ~5 ~39 minecraft:bamboo
fill ~-21 ~1 ~39 ~-21 ~3 ~39 minecraft:bamboo
fill ~-23 ~1 ~41 ~-23 ~3 ~41 minecraft:bamboo
fill ~19 ~1 ~-38 ~19 ~5 ~-38 minecraft:bamboo
fill ~20 ~1 ~-39 ~20 ~5 ~-39 minecraft:bamboo
fill ~22 ~1 ~-40 ~22 ~3 ~-40 minecraft:bamboo
fill ~-40 ~0 ~-40 ~-32 ~0 ~-34 minecraft:stone_bricks
fill ~-39 ~0 ~-39 ~-33 ~0 ~-35 minecraft:smooth_sandstone
setblock ~-38 ~1 ~-37 minecraft:mossy_cobblestone
setblock ~-38 ~2 ~-37 minecraft:andesite_slab
setblock ~-35 ~1 ~-38 minecraft:mossy_cobblestone
setblock ~-35 ~2 ~-38 minecraft:andesite_slab
setblock ~-34 ~1 ~-36 minecraft:mossy_cobblestone
setblock ~-34 ~2 ~-36 minecraft:andesite_slab
fill ~31 ~0 ~37 ~39 ~0 ~43 minecraft:stone_bricks
fill ~32 ~0 ~38 ~38 ~0 ~42 minecraft:smooth_sandstone
setblock ~33 ~1 ~40 minecraft:mossy_cobblestone
setblock ~33 ~2 ~40 minecraft:andesite_slab
setblock ~36 ~1 ~39 minecraft:mossy_cobblestone
setblock ~36 ~2 ~39 minecraft:andesite_slab
setblock ~37 ~1 ~41 minecraft:mossy_cobblestone
setblock ~37 ~2 ~41 minecraft:andesite_slab
fill ~-37 ~0 ~37 ~-31 ~0 ~41 minecraft:spruce_planks
fill ~-37 ~1 ~37 ~-37 ~3 ~37 minecraft:stripped_spruce_log
fill ~-37 ~1 ~41 ~-37 ~3 ~41 minecraft:stripped_spruce_log
fill ~-31 ~1 ~37 ~-31 ~3 ~37 minecraft:stripped_spruce_log
fill ~-31 ~1 ~41 ~-31 ~3 ~41 minecraft:stripped_spruce_log
fill ~-38 ~4 ~36 ~-30 ~4 ~42 minecraft:deepslate_tiles
fill ~-38 ~4 ~36 ~-30 ~4 ~36 minecraft:deepslate_tile_stairs[facing=south]
fill ~-38 ~4 ~42 ~-30 ~4 ~42 minecraft:deepslate_tile_stairs[facing=north]
fill ~-38 ~5 ~38 ~-30 ~5 ~40 minecraft:deepslate_tile_slab[type=bottom]
setblock ~-34 ~3 ~39 minecraft:lantern[hanging=true]
fill ~32 ~0 ~-40 ~38 ~0 ~-36 minecraft:spruce_planks
fill ~32 ~1 ~-40 ~32 ~3 ~-40 minecraft:stripped_spruce_log
fill ~32 ~1 ~-36 ~32 ~3 ~-36 minecraft:stripped_spruce_log
fill ~38 ~1 ~-40 ~38 ~3 ~-40 minecraft:stripped_spruce_log
fill ~38 ~1 ~-36 ~38 ~3 ~-36 minecraft:stripped_spruce_log
fill ~31 ~4 ~-41 ~39 ~4 ~-35 minecraft:deepslate_tiles
fill ~31 ~4 ~-41 ~39 ~4 ~-41 minecraft:deepslate_tile_stairs[facing=south]
fill ~31 ~4 ~-35 ~39 ~4 ~-35 minecraft:deepslate_tile_stairs[facing=north]
fill ~31 ~5 ~-39 ~39 ~5 ~-37 minecraft:deepslate_tile_slab[type=bottom]
setblock ~35 ~3 ~-38 minecraft:lantern[hanging=true]
fill ~-32 ~1 ~2 ~-26 ~5 ~8 minecraft:air
fill ~-32 ~0 ~2 ~-26 ~0 ~8 minecraft:gravel
fill ~-30 ~0 ~4 ~-28 ~0 ~6 minecraft:chiseled_stone_bricks
setblock ~-29 ~0 ~5 minecraft:bricks
setblock ~-29 ~1 ~5 minecraft:stone_pressure_plate
fill ~25 ~1 ~-9 ~31 ~5 ~-3 minecraft:air
fill ~25 ~0 ~-9 ~31 ~0 ~-3 minecraft:gravel
fill ~27 ~0 ~-7 ~29 ~0 ~-5 minecraft:chiseled_stone_bricks
setblock ~28 ~0 ~-6 minecraft:bricks
setblock ~28 ~1 ~-6 minecraft:stone_pressure_plate
fill ~5 ~1 ~-37 ~11 ~5 ~-31 minecraft:air
fill ~5 ~0 ~-37 ~11 ~0 ~-31 minecraft:gravel
fill ~7 ~0 ~-35 ~9 ~0 ~-33 minecraft:chiseled_stone_bricks
setblock ~8 ~0 ~-34 minecraft:bricks
setblock ~8 ~1 ~-34 minecraft:stone_pressure_plate
fill ~16 ~1 ~32 ~22 ~5 ~38 minecraft:air
fill ~16 ~0 ~32 ~22 ~0 ~38 minecraft:gravel
fill ~18 ~0 ~34 ~20 ~0 ~36 minecraft:chiseled_stone_bricks
setblock ~19 ~0 ~35 minecraft:bricks
setblock ~19 ~1 ~35 minecraft:stone_pressure_plate

# Scatter the stationary test targets across the eastern clearing.
setblock ~6 ~0 ~-17 minecraft:smooth_stone
fill ~6 ~1 ~-17 ~6 ~4 ~-17 minecraft:air
fill ~5 ~11 ~-18 ~7 ~11 ~-16 minecraft:dark_oak_planks
execute positioned ~6.5 ~1 ~-16.5 summon minecraft:marker run function oa:practice/dummy_spawn_init {tier:0}
setblock ~13 ~0 ~-15 minecraft:smooth_stone
fill ~13 ~1 ~-15 ~13 ~4 ~-15 minecraft:air
fill ~12 ~11 ~-16 ~14 ~11 ~-14 minecraft:dark_oak_planks
execute positioned ~13.5 ~1 ~-14.5 summon minecraft:marker run function oa:practice/dummy_spawn_init {tier:3}
setblock ~20 ~0 ~-18 minecraft:smooth_stone
fill ~20 ~1 ~-18 ~20 ~4 ~-18 minecraft:air
fill ~19 ~11 ~-19 ~21 ~11 ~-17 minecraft:dark_oak_planks
execute positioned ~20.5 ~1 ~-17.5 summon minecraft:marker run function oa:practice/dummy_spawn_init {tier:1}
setblock ~24 ~0 ~-12 minecraft:smooth_stone
fill ~24 ~1 ~-12 ~24 ~4 ~-12 minecraft:air
fill ~23 ~11 ~-13 ~25 ~11 ~-11 minecraft:dark_oak_planks
execute positioned ~24.5 ~1 ~-11.5 summon minecraft:marker run function oa:practice/dummy_spawn_init {tier:5}
setblock ~8 ~0 ~-10 minecraft:smooth_stone
fill ~8 ~1 ~-10 ~8 ~4 ~-10 minecraft:air
fill ~7 ~11 ~-11 ~9 ~11 ~-9 minecraft:dark_oak_planks
execute positioned ~8.5 ~1 ~-9.5 summon minecraft:marker run function oa:practice/dummy_spawn_init {tier:4}
setblock ~16 ~0 ~-9 minecraft:smooth_stone
fill ~16 ~1 ~-9 ~16 ~4 ~-9 minecraft:air
fill ~15 ~11 ~-10 ~17 ~11 ~-8 minecraft:dark_oak_planks
execute positioned ~16.5 ~1 ~-8.5 summon minecraft:marker run function oa:practice/dummy_spawn_init {tier:2}
setblock ~5 ~0 ~-4 minecraft:smooth_stone
fill ~5 ~1 ~-4 ~5 ~4 ~-4 minecraft:air
fill ~4 ~11 ~-5 ~6 ~11 ~-3 minecraft:dark_oak_planks
execute positioned ~5.5 ~1 ~-3.5 summon minecraft:marker run function oa:practice/dummy_spawn_init {tier:5}
setblock ~12 ~0 ~-5 minecraft:smooth_stone
fill ~12 ~1 ~-5 ~12 ~4 ~-5 minecraft:air
fill ~11 ~11 ~-6 ~13 ~11 ~-4 minecraft:dark_oak_planks
execute positioned ~12.5 ~1 ~-4.5 summon minecraft:marker run function oa:practice/dummy_spawn_init {tier:1}
setblock ~21 ~0 ~-4 minecraft:smooth_stone
fill ~21 ~1 ~-4 ~21 ~4 ~-4 minecraft:air
fill ~20 ~11 ~-5 ~22 ~11 ~-3 minecraft:dark_oak_planks
execute positioned ~21.5 ~1 ~-3.5 summon minecraft:marker run function oa:practice/dummy_spawn_init {tier:0}
setblock ~9 ~0 ~3 minecraft:smooth_stone
fill ~9 ~1 ~3 ~9 ~4 ~3 minecraft:air
fill ~8 ~11 ~2 ~10 ~11 ~4 minecraft:dark_oak_planks
execute positioned ~9.5 ~1 ~3.5 summon minecraft:marker run function oa:practice/dummy_spawn_init {tier:2}
setblock ~17 ~0 ~5 minecraft:smooth_stone
fill ~17 ~1 ~5 ~17 ~4 ~5 minecraft:air
fill ~16 ~11 ~4 ~18 ~11 ~6 minecraft:dark_oak_planks
execute positioned ~17.5 ~1 ~5.5 summon minecraft:marker run function oa:practice/dummy_spawn_init {tier:4}
setblock ~24 ~0 ~2 minecraft:smooth_stone
fill ~24 ~1 ~2 ~24 ~4 ~2 minecraft:air
fill ~23 ~11 ~1 ~25 ~11 ~3 minecraft:dark_oak_planks
execute positioned ~24.5 ~1 ~2.5 summon minecraft:marker run function oa:practice/dummy_spawn_init {tier:3}

setblock ~-15 ~1 ~7 minecraft:chiseled_stone_bricks
setblock ~-16 ~1 ~7 minecraft:stone_button[face=wall,facing=west]
summon minecraft:marker ~-15.5 ~1 ~7.5 {Tags:["oa.physical_button","oa.button_practice"],data:{action:"practice/click/cooldown"}}
setblock ~-14 ~1 ~7 minecraft:stone_button[face=wall,facing=east]
summon minecraft:marker ~-13.5 ~1 ~7.5 {Tags:["oa.physical_button","oa.button_practice"],data:{action:"practice/click/cooldown"}}
setblock ~-15 ~1 ~8 minecraft:stone_button[face=wall,facing=south]
summon minecraft:marker ~-14.5 ~1 ~8.5 {Tags:["oa.physical_button","oa.button_practice"],data:{action:"practice/click/cooldown"}}
setblock ~-15 ~1 ~6 minecraft:stone_button[face=wall,facing=north]
summon minecraft:marker ~-14.5 ~1 ~6.5 {Tags:["oa.physical_button","oa.button_practice"],data:{action:"practice/click/cooldown"}}
summon minecraft:text_display ~-14.5 ~2.85 ~7.5 {Tags:["oa.practice_controls"],text:{text:"CTリセット",color:"aqua"},billboard:"center",shadow:1b,view_range:0.5f}

setblock ~27 ~1 ~7 minecraft:chiseled_stone_bricks
setblock ~26 ~1 ~7 minecraft:stone_button[face=wall,facing=west]
summon minecraft:marker ~26.5 ~1 ~7.5 {Tags:["oa.physical_button","oa.button_practice"],data:{action:"practice/click/cooldown"}}
setblock ~28 ~1 ~7 minecraft:stone_button[face=wall,facing=east]
summon minecraft:marker ~28.5 ~1 ~7.5 {Tags:["oa.physical_button","oa.button_practice"],data:{action:"practice/click/cooldown"}}
setblock ~27 ~1 ~8 minecraft:stone_button[face=wall,facing=south]
summon minecraft:marker ~27.5 ~1 ~8.5 {Tags:["oa.physical_button","oa.button_practice"],data:{action:"practice/click/cooldown"}}
setblock ~27 ~1 ~6 minecraft:stone_button[face=wall,facing=north]
summon minecraft:marker ~27.5 ~1 ~6.5 {Tags:["oa.physical_button","oa.button_practice"],data:{action:"practice/click/cooldown"}}
summon minecraft:text_display ~27.5 ~2.85 ~7.5 {Tags:["oa.practice_controls"],text:{text:"CTリセット",color:"aqua"},billboard:"center",shadow:1b,view_range:0.5f}
function oa:practice/ext_build
