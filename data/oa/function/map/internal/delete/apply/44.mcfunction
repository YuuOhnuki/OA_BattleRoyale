# 生成：scripts/gen_map_delete.py
scoreboard players set #stage oa.map2 3
execute if score #arena_delete oa.map2 matches 1 run function oa:map/internal/delete/clear_arena/44
execute unless score #arena_delete oa.map2 matches 1 run fill ~-24 ~-20 ~-24 ~7 ~0 ~7 minecraft:air
execute unless score #arena_delete oa.map2 matches 1 run fill ~-24 ~1 ~-24 ~7 ~30 ~7 minecraft:air
execute unless score #arena_delete oa.map2 matches 1 run execute positioned ~-24 ~-20 ~-24 run kill @e[tag=br.chest,dx=31,dy=28,dz=31]
execute unless score #arena_delete oa.map2 matches 1 run execute positioned ~-24 ~-20 ~-24 run kill @e[tag=br.ore,dx=31,dy=28,dz=31]
execute unless score #arena_delete oa.map2 matches 1 run execute positioned ~-24 ~-20 ~-24 run kill @e[tag=br.matchloot,dx=31,dy=28,dz=31]
function oa:map/internal/tiles/release/44
function oa:map/internal/delete/advance
