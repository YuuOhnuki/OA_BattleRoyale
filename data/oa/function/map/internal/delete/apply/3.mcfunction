fill ~-56 ~-20 ~-152 ~-25 ~0 ~-121 minecraft:air
execute positioned ~-56 ~-20 ~-152 run kill @e[tag=br.chest,dx=31,dy=28,dz=31]
execute positioned ~-56 ~-20 ~-152 run kill @e[tag=br.ore,dx=31,dy=28,dz=31]
execute positioned ~-56 ~-20 ~-152 run kill @e[tag=br.matchloot,dx=31,dy=28,dz=31]
function oa:map/internal/tiles/release/3
function oa:map/internal/delete/advance
