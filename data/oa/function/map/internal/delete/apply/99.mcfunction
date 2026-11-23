# 生成：scripts/gen_map_delete.py
scoreboard players set #stage oa.map2 3
execute if score #arena_delete oa.map2 matches 1 run function oa:map/internal/delete/clear_arena/99
execute unless score #arena_delete oa.map2 matches 1 run fill ~136 ~-20 ~136 ~152 ~0 ~152 minecraft:air
execute unless score #arena_delete oa.map2 matches 1 run execute positioned ~136 ~-20 ~136 run kill @e[tag=br.chest,dx=16,dy=28,dz=16]
execute unless score #arena_delete oa.map2 matches 1 run execute positioned ~136 ~-20 ~136 run kill @e[tag=br.ore,dx=16,dy=28,dz=16]
execute unless score #arena_delete oa.map2 matches 1 run execute positioned ~136 ~-20 ~136 run kill @e[tag=br.matchloot,dx=16,dy=28,dz=16]
function oa:map/internal/tiles/release/99
function oa:map/internal/delete/advance
