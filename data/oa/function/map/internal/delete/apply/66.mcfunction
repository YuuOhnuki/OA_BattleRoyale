fill ~40 ~-20 ~40 ~71 ~0 ~71 minecraft:air
execute positioned ~40 ~-20 ~40 run kill @e[tag=br.chest,dx=31,dy=28,dz=31]
execute positioned ~40 ~-20 ~40 run kill @e[tag=br.ore,dx=31,dy=28,dz=31]
execute positioned ~40 ~-20 ~40 run kill @e[tag=br.matchloot,dx=31,dy=28,dz=31]
function oa:map/internal/tiles/release/66
function oa:map/internal/delete/advance
