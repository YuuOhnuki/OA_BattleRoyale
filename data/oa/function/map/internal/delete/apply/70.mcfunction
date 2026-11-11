fill ~-152 ~-20 ~72 ~-121 ~0 ~103 minecraft:air
execute positioned ~-152 ~-20 ~72 run kill @e[tag=br.chest,dx=31,dy=28,dz=31]
execute positioned ~-152 ~-20 ~72 run kill @e[tag=br.ore,dx=31,dy=28,dz=31]
execute positioned ~-152 ~-20 ~72 run kill @e[tag=br.matchloot,dx=31,dy=28,dz=31]
function oa:map/internal/tiles/release/70
function oa:map/internal/delete/advance
