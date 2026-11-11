fill ~-56 ~-20 ~-120 ~-25 ~0 ~-89 minecraft:air
execute positioned ~-56 ~-20 ~-120 run kill @e[tag=br.chest,dx=31,dy=28,dz=31]
execute positioned ~-56 ~-20 ~-120 run kill @e[tag=br.ore,dx=31,dy=28,dz=31]
execute positioned ~-56 ~-20 ~-120 run kill @e[tag=br.matchloot,dx=31,dy=28,dz=31]
function oa:map/internal/tiles/release/13
function oa:map/internal/delete/advance
