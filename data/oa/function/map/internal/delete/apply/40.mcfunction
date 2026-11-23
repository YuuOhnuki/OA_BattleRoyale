# 生成：scripts/gen_map_delete.py
scoreboard players set #stage oa.map2 3
execute if score #arena_delete oa.map2 matches 1 run function oa:map/internal/delete/clear_arena/40
execute unless score #arena_delete oa.map2 matches 1 run fill ~-152 ~-20 ~-24 ~-121 ~0 ~7 minecraft:air
execute unless score #arena_delete oa.map2 matches 1 run execute positioned ~-152 ~-20 ~-24 run kill @e[tag=br.chest,dx=31,dy=28,dz=31]
execute unless score #arena_delete oa.map2 matches 1 run execute positioned ~-152 ~-20 ~-24 run kill @e[tag=br.ore,dx=31,dy=28,dz=31]
execute unless score #arena_delete oa.map2 matches 1 run execute positioned ~-152 ~-20 ~-24 run kill @e[tag=br.matchloot,dx=31,dy=28,dz=31]
function oa:map/internal/tiles/release/40
function oa:map/internal/delete/advance
