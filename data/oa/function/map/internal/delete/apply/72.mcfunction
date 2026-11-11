fill ~-88 ~-20 ~72 ~-57 ~0 ~103 minecraft:air
execute positioned ~-88 ~-20 ~72 run kill @e[tag=br.chest,dx=31,dy=28,dz=31]
execute positioned ~-88 ~-20 ~72 run kill @e[tag=br.ore,dx=31,dy=28,dz=31]
execute positioned ~-88 ~-20 ~72 run kill @e[tag=br.matchloot,dx=31,dy=28,dz=31]
function oa:map/internal/tiles/release/72
function oa:map/internal/delete/advance
