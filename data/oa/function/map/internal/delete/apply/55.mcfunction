fill ~8 ~-20 ~8 ~39 ~0 ~39 minecraft:air
fill ~8 ~1 ~8 ~39 ~30 ~39 minecraft:air
execute positioned ~8 ~-20 ~8 run kill @e[tag=br.chest,dx=31,dy=28,dz=31]
execute positioned ~8 ~-20 ~8 run kill @e[tag=br.ore,dx=31,dy=28,dz=31]
execute positioned ~8 ~-20 ~8 run kill @e[tag=br.matchloot,dx=31,dy=28,dz=31]
function oa:map/internal/tiles/release/55
function oa:map/internal/delete/advance
