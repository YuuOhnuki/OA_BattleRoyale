fill ~104 ~-20 ~8 ~135 ~0 ~39 minecraft:air
execute positioned ~104 ~-20 ~8 run kill @e[tag=br.chest,dx=31,dy=28,dz=31]
execute positioned ~104 ~-20 ~8 run kill @e[tag=br.ore,dx=31,dy=28,dz=31]
execute positioned ~104 ~-20 ~8 run kill @e[tag=br.matchloot,dx=31,dy=28,dz=31]
function oa:map/internal/tiles/release/58
function oa:map/internal/delete/advance
