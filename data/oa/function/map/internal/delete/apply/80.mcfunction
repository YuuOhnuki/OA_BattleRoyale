fill ~-152 ~-20 ~104 ~-121 ~0 ~135 minecraft:air
execute positioned ~-152 ~-20 ~104 run kill @e[tag=br.chest,dx=31,dy=28,dz=31]
execute positioned ~-152 ~-20 ~104 run kill @e[tag=br.ore,dx=31,dy=28,dz=31]
execute positioned ~-152 ~-20 ~104 run kill @e[tag=br.matchloot,dx=31,dy=28,dz=31]
function oa:map/internal/tiles/release/80
function oa:map/internal/delete/advance
