# 生成：scripts/gen_map_delete.py
scoreboard players set #stage oa.map2 3
execute if score #arena_delete oa.map2 matches 1 run function oa:map/internal/delete/clear_arena/92
execute unless score #arena_delete oa.map2 matches 1 run fill ~-88 ~-20 ~136 ~-57 ~0 ~152 minecraft:air
execute unless score #arena_delete oa.map2 matches 1 run execute positioned ~-88 ~-20 ~136 run kill @e[tag=br.chest,dx=31,dy=28,dz=16]
execute unless score #arena_delete oa.map2 matches 1 run execute positioned ~-88 ~-20 ~136 run kill @e[tag=br.ore,dx=31,dy=28,dz=16]
execute unless score #arena_delete oa.map2 matches 1 run execute positioned ~-88 ~-20 ~136 run kill @e[tag=br.matchloot,dx=31,dy=28,dz=16]
function oa:map/internal/tiles/release/92
function oa:map/internal/delete/advance
