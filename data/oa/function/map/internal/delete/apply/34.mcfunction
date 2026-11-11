fill ~-24 ~-20 ~-56 ~7 ~0 ~-25 minecraft:air
fill ~-24 ~1 ~-56 ~7 ~30 ~-25 minecraft:air
execute positioned ~-24 ~-20 ~-56 run kill @e[tag=br.chest,dx=31,dy=28,dz=31]
execute positioned ~-24 ~-20 ~-56 run kill @e[tag=br.ore,dx=31,dy=28,dz=31]
execute positioned ~-24 ~-20 ~-56 run kill @e[tag=br.matchloot,dx=31,dy=28,dz=31]
function oa:map/internal/tiles/release/34
function oa:map/internal/delete/advance
