fill ~-24 ~-20 ~-24 ~7 ~0 ~7 minecraft:air
fill ~-24 ~1 ~-24 ~7 ~30 ~7 minecraft:air
execute positioned ~-24 ~-20 ~-24 run kill @e[tag=br.chest,dx=31,dy=28,dz=31]
execute positioned ~-24 ~-20 ~-24 run kill @e[tag=br.ore,dx=31,dy=28,dz=31]
execute positioned ~-24 ~-20 ~-24 run kill @e[tag=br.matchloot,dx=31,dy=28,dz=31]
function oa:map/internal/tiles/release/44
function oa:map/internal/delete/advance
