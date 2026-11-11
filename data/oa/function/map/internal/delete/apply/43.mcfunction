fill ~-56 ~-20 ~-24 ~-25 ~0 ~7 minecraft:air
fill ~-56 ~1 ~-24 ~-25 ~30 ~7 minecraft:air
execute positioned ~-56 ~-20 ~-24 run kill @e[tag=br.chest,dx=31,dy=28,dz=31]
execute positioned ~-56 ~-20 ~-24 run kill @e[tag=br.ore,dx=31,dy=28,dz=31]
execute positioned ~-56 ~-20 ~-24 run kill @e[tag=br.matchloot,dx=31,dy=28,dz=31]
function oa:map/internal/tiles/release/43
function oa:map/internal/delete/advance
