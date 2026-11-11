fill ~8 ~-20 ~-24 ~39 ~0 ~7 minecraft:air
fill ~8 ~1 ~-24 ~39 ~30 ~7 minecraft:air
execute positioned ~8 ~-20 ~-24 run kill @e[tag=br.chest,dx=31,dy=28,dz=31]
execute positioned ~8 ~-20 ~-24 run kill @e[tag=br.ore,dx=31,dy=28,dz=31]
execute positioned ~8 ~-20 ~-24 run kill @e[tag=br.matchloot,dx=31,dy=28,dz=31]
function oa:map/internal/tiles/release/45
function oa:map/internal/delete/advance
