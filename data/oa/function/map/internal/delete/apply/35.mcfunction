fill ~8 ~-20 ~-56 ~39 ~0 ~-25 minecraft:air
execute positioned ~8 ~-20 ~-56 run kill @e[tag=br.chest,dx=31,dy=28,dz=31]
execute positioned ~8 ~-20 ~-56 run kill @e[tag=br.ore,dx=31,dy=28,dz=31]
execute positioned ~8 ~-20 ~-56 run kill @e[tag=br.matchloot,dx=31,dy=28,dz=31]
function oa:map/internal/tiles/release/35
function oa:map/internal/delete/advance
