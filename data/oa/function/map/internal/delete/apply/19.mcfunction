fill ~136 ~-20 ~-120 ~152 ~0 ~-89 minecraft:air
execute positioned ~136 ~-20 ~-120 run kill @e[tag=br.chest,dx=16,dy=28,dz=31]
execute positioned ~136 ~-20 ~-120 run kill @e[tag=br.ore,dx=16,dy=28,dz=31]
execute positioned ~136 ~-20 ~-120 run kill @e[tag=br.matchloot,dx=16,dy=28,dz=31]
function oa:map/internal/tiles/release/19
function oa:map/internal/delete/advance
