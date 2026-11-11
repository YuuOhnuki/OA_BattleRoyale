fill ~-24 ~-20 ~-120 ~7 ~0 ~-89 minecraft:air
execute positioned ~-24 ~-20 ~-120 run kill @e[tag=br.chest,dx=31,dy=28,dz=31]
execute positioned ~-24 ~-20 ~-120 run kill @e[tag=br.ore,dx=31,dy=28,dz=31]
execute positioned ~-24 ~-20 ~-120 run kill @e[tag=br.matchloot,dx=31,dy=28,dz=31]
function oa:map/internal/tiles/release/14
function oa:map/internal/delete/advance
