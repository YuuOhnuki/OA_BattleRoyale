# 生成：scripts/gen_map_delete.py
scoreboard players set #stage oa.map2 3
execute if score #arena_delete oa.map2 matches 1 run function oa:map/internal/delete/clear_arena/66
execute unless score #arena_delete oa.map2 matches 1 run fill ~40 ~-20 ~40 ~71 ~0 ~71 minecraft:air
execute unless score #arena_delete oa.map2 matches 1 run execute positioned ~40 ~-20 ~40 run kill @e[tag=br.chest,dx=31,dy=28,dz=31]
execute unless score #arena_delete oa.map2 matches 1 run execute positioned ~40 ~-20 ~40 run kill @e[tag=br.ore,dx=31,dy=28,dz=31]
execute unless score #arena_delete oa.map2 matches 1 run execute positioned ~40 ~-20 ~40 run kill @e[tag=br.matchloot,dx=31,dy=28,dz=31]
function oa:map/internal/tiles/release/66
function oa:map/internal/delete/advance
