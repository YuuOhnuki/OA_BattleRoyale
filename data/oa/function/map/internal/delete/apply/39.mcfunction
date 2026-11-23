# 生成：scripts/gen_map_delete.py
scoreboard players set #stage oa.map2 3
execute if score #arena_delete oa.map2 matches 1 run function oa:map/internal/delete/clear_arena/39
execute unless score #arena_delete oa.map2 matches 1 run fill ~136 ~-20 ~-56 ~152 ~0 ~-25 minecraft:air
execute unless score #arena_delete oa.map2 matches 1 run execute positioned ~136 ~-20 ~-56 run kill @e[tag=br.chest,dx=16,dy=28,dz=31]
execute unless score #arena_delete oa.map2 matches 1 run execute positioned ~136 ~-20 ~-56 run kill @e[tag=br.ore,dx=16,dy=28,dz=31]
execute unless score #arena_delete oa.map2 matches 1 run execute positioned ~136 ~-20 ~-56 run kill @e[tag=br.matchloot,dx=16,dy=28,dz=31]
function oa:map/internal/tiles/release/39
function oa:map/internal/delete/advance
