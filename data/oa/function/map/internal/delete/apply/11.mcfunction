fill ~-120 ~-20 ~-120 ~-89 ~0 ~-89 minecraft:air
execute positioned ~-120 ~-20 ~-120 run kill @e[tag=br.chest,dx=31,dy=28,dz=31]
execute positioned ~-120 ~-20 ~-120 run kill @e[tag=br.ore,dx=31,dy=28,dz=31]
execute positioned ~-120 ~-20 ~-120 run kill @e[tag=br.matchloot,dx=31,dy=28,dz=31]
function oa:map/internal/tiles/release/11
function oa:map/internal/delete/advance
