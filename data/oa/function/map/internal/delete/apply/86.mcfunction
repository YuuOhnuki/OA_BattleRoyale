fill ~40 ~-20 ~104 ~71 ~0 ~135 minecraft:air
execute positioned ~40 ~-20 ~104 run kill @e[tag=br.chest,dx=31,dy=28,dz=31]
execute positioned ~40 ~-20 ~104 run kill @e[tag=br.ore,dx=31,dy=28,dz=31]
execute positioned ~40 ~-20 ~104 run kill @e[tag=br.matchloot,dx=31,dy=28,dz=31]
function oa:map/internal/tiles/release/86
function oa:map/internal/delete/advance
