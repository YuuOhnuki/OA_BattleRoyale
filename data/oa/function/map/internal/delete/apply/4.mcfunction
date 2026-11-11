fill ~-24 ~-20 ~-152 ~7 ~0 ~-121 minecraft:air
execute positioned ~-24 ~-20 ~-152 run kill @e[tag=br.chest,dx=31,dy=28,dz=31]
execute positioned ~-24 ~-20 ~-152 run kill @e[tag=br.ore,dx=31,dy=28,dz=31]
execute positioned ~-24 ~-20 ~-152 run kill @e[tag=br.matchloot,dx=31,dy=28,dz=31]
function oa:map/internal/tiles/release/4
function oa:map/internal/delete/advance
