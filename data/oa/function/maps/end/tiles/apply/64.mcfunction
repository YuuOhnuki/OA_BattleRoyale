execute if score #mode oa.map2 matches 0 run function oa:maps/end/tiles/place/64
execute if score #state oa.map2 matches 2 run return 0
execute positioned ~-24 ~-40 ~40 run kill @e[type=minecraft:marker,tag=br.chest,dx=31,dy=80,dz=31]
execute positioned ~-24 ~-40 ~40 run kill @e[type=minecraft:marker,tag=br.ore,dx=31,dy=80,dz=31]
execute positioned ~-24 ~-40 ~40 run kill @e[type=minecraft:marker,tag=oa.gim,dx=31,dy=80,dz=31]
execute positioned ~-24 ~-40 ~40 run kill @e[type=minecraft:block_display,tag=oa.mdeco,dx=31,dy=80,dz=31]
execute positioned ~-24 ~-40 ~40 run kill @e[type=minecraft:end_crystal,tag=oa.mdeco,dx=31,dy=80,dz=31]
scoreboard players set #stage oa.map2 2
scoreboard players set #localc oa.map2 0
scoreboard players set #localo oa.map2 0
scoreboard players set #expectedc oa.map2 1
scoreboard players set #expectedo oa.map2 1
execute positioned ~-6 ~-25 ~54 if block ~ ~ ~ minecraft:redstone_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_3
execute positioned ~-13 ~1 ~48 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #mode oa.map2 matches 0 positioned ~-13 ~1 ~48 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute positioned ~-8 ~-25 ~52 align xyz positioned ~0.5 ~0 ~0.5 run summon minecraft:marker ~ ~ ~ {Tags:["oa.gim","oa.gim_up","oa.gim_up_31"]}
execute positioned ~-10 ~37 ~44 align xyz positioned ~0.5 ~0 ~0.5 run summon minecraft:block_display ~ ~ ~ {Tags:["oa.mdeco"],block_state:"minecraft:purpur_block",view_range:6.0f,Rotation:[0.0f,0.0f],transformation:{translation:[-1.300f,0.000f,-1.300f],left_rotation:[0.2706f,0.0000f,0.2706f,0.9239f],scale:[2.600f,2.600f,2.600f],right_rotation:[0.0f,0.0f,0.0f,1.0f]},brightness:{block:15,sky:15}}
execute positioned ~-10 ~37 ~44 align xyz positioned ~0.5 ~0 ~0.5 run summon minecraft:block_display ~ ~ ~ {Tags:["oa.mdeco"],block_state:"minecraft:end_rod",view_range:6.0f,Rotation:[0.0f,0.0f],transformation:{translation:[-0.150f,-1.560f,-0.150f],left_rotation:[0.0000f,0.0000f,0.0000f,1.0000f],scale:[0.300f,5.720f,0.300f],right_rotation:[0.0f,0.0f,0.0f,1.0f]},brightness:{block:15,sky:15}}
execute if score #sv2 oa.map2 matches 1 run scoreboard players add #expectedo oa.map2 2
execute if score #sv2 oa.map2 matches 1 positioned ~3 ~1 ~67 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute if score #sv2 oa.map2 matches 1 positioned ~-10 ~1 ~67 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute unless score #localc oa.map2 = #expectedc oa.map2 run return run function oa:map/internal/job/failed
execute unless score #localo oa.map2 = #expectedo oa.map2 run return run function oa:map/internal/job/failed
scoreboard players operation #chests oa.map2 += #localc oa.map2
scoreboard players operation #ores oa.map2 += #localo oa.map2
function oa:maps/end/tiles/release/64
scoreboard players add #tile oa.map2 1
execute store result storage oa_map2:args tile int 1 run scoreboard players get #tile oa.map2
execute if score #tile oa.map2 matches 100.. run return run function oa:map/internal/job/finish
schedule function oa:map/internal/job/next 1t replace
