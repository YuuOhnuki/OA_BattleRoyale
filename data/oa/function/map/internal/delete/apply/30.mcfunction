fill ~-152 ~-20 ~-56 ~-121 ~0 ~-25 minecraft:air
execute positioned ~-152 ~-20 ~-56 run kill @e[tag=br.chest,dx=31,dy=28,dz=31]
execute positioned ~-152 ~-20 ~-56 run kill @e[tag=br.ore,dx=31,dy=28,dz=31]
execute positioned ~-152 ~-20 ~-56 run kill @e[tag=br.matchloot,dx=31,dy=28,dz=31]
function oa:map/internal/tiles/release/30
function oa:map/internal/delete/advance
