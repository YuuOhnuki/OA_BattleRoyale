execute if score #mode oa.map2 matches 0 run function oa:maps/end/tiles/place/80
execute if score #state oa.map2 matches 2 run return 0
execute positioned ~-152 ~-40 ~104 run kill @e[type=minecraft:marker,tag=br.chest,dx=31,dy=80,dz=31]
execute positioned ~-152 ~-40 ~104 run kill @e[type=minecraft:marker,tag=br.ore,dx=31,dy=80,dz=31]
execute positioned ~-152 ~-40 ~104 run kill @e[type=minecraft:marker,tag=oa.gim,dx=31,dy=80,dz=31]
execute positioned ~-152 ~-40 ~104 run kill @e[type=minecraft:block_display,tag=oa.mdeco,dx=31,dy=80,dz=31]
scoreboard players set #stage oa.map2 2
scoreboard players set #localc oa.map2 0
scoreboard players set #localo oa.map2 0
scoreboard players set #expectedc oa.map2 3
scoreboard players set #expectedo oa.map2 1
execute positioned ~-131 ~1 ~130 if block ~ ~ ~ minecraft:coal_ore align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_1
execute positioned ~-128 ~1 ~124 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute positioned ~-132 ~1 ~131 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute positioned ~-121 ~1 ~132 if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest
execute if score #mode oa.map2 matches 0 positioned ~-128 ~1 ~124 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #mode oa.map2 matches 0 positioned ~-132 ~1 ~131 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if score #mode oa.map2 matches 0 positioned ~-121 ~1 ~132 if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute positioned ~-128 ~22 ~110 align xyz positioned ~0.5 ~0 ~0.5 run summon minecraft:block_display ~ ~ ~ {Tags:["oa.mdeco"],block_state:"minecraft:smooth_quartz",view_range:6.0f,Rotation:[10.0f,0.0f],transformation:{translation:[-4.500f,0.000f,-4.500f],left_rotation:[0.0000f,0.0000f,0.0000f,1.0000f],scale:[9.000f,0.800f,9.000f],right_rotation:[0.0f,0.0f,0.0f,1.0f]}}
execute positioned ~-128 ~22 ~110 align xyz positioned ~0.5 ~0 ~0.5 run summon minecraft:block_display ~ ~ ~ {Tags:["oa.mdeco"],block_state:"minecraft:smooth_quartz",view_range:6.0f,Rotation:[55.0f,0.0f],transformation:{translation:[-3.200f,0.600f,-3.200f],left_rotation:[0.0000f,0.0000f,0.0000f,1.0000f],scale:[6.400f,0.800f,6.400f],right_rotation:[0.0f,0.0f,0.0f,1.0f]}}
execute positioned ~-128 ~22 ~110 align xyz positioned ~0.5 ~0 ~0.5 run summon minecraft:block_display ~ ~ ~ {Tags:["oa.mdeco"],block_state:"minecraft:white_concrete",view_range:6.0f,Rotation:[10.0f,0.0f],transformation:{translation:[-5.500f,0.250f,-1.500f],left_rotation:[0.0000f,0.0000f,0.0000f,1.0000f],scale:[11.000f,0.300f,3.000f],right_rotation:[0.0f,0.0f,0.0f,1.0f]}}
execute positioned ~-128 ~22 ~110 align xyz positioned ~0.5 ~0 ~0.5 run summon minecraft:block_display ~ ~ ~ {Tags:["oa.mdeco"],block_state:"minecraft:white_concrete",view_range:6.0f,Rotation:[10.0f,0.0f],transformation:{translation:[-1.500f,0.250f,-5.500f],left_rotation:[0.0000f,0.0000f,0.0000f,1.0000f],scale:[3.000f,0.300f,11.000f],right_rotation:[0.0f,0.0f,0.0f,1.0f]}}
execute positioned ~-128 ~22 ~110 align xyz positioned ~0.5 ~0 ~0.5 run summon minecraft:block_display ~ ~ ~ {Tags:["oa.mdeco"],block_state:"minecraft:light_blue_stained_glass",view_range:6.0f,Rotation:[10.0f,0.0f],transformation:{translation:[-1.800f,1.300f,-1.800f],left_rotation:[0.0000f,0.0000f,0.0000f,1.0000f],scale:[3.600f,2.200f,3.600f],right_rotation:[0.0f,0.0f,0.0f,1.0f]}}
execute positioned ~-128 ~22 ~110 align xyz positioned ~0.5 ~0 ~0.5 run summon minecraft:block_display ~ ~ ~ {Tags:["oa.mdeco"],block_state:"minecraft:sea_lantern",view_range:6.0f,Rotation:[10.0f,0.0f],transformation:{translation:[-1.500f,-0.400f,-1.500f],left_rotation:[0.0000f,0.0000f,0.0000f,1.0000f],scale:[3.000f,0.400f,3.000f],right_rotation:[0.0f,0.0f,0.0f,1.0f]},brightness:{block:15,sky:15}}
execute unless score #localc oa.map2 = #expectedc oa.map2 run return run function oa:map/internal/job/failed
execute unless score #localo oa.map2 = #expectedo oa.map2 run return run function oa:map/internal/job/failed
scoreboard players operation #chests oa.map2 += #localc oa.map2
scoreboard players operation #ores oa.map2 += #localo oa.map2
function oa:maps/end/tiles/release/80
scoreboard players add #tile oa.map2 1
execute store result storage oa_map2:args tile int 1 run scoreboard players get #tile oa.map2
execute if score #tile oa.map2 matches 100.. run return run function oa:map/internal/job/finish
schedule function oa:map/internal/job/next 1t replace
