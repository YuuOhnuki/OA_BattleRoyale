fill ~8 ~-20 ~136 ~39 ~0 ~152 minecraft:air
execute positioned ~8 ~-20 ~136 run kill @e[tag=br.chest,dx=31,dy=28,dz=16]
execute positioned ~8 ~-20 ~136 run kill @e[tag=br.ore,dx=31,dy=28,dz=16]
execute positioned ~8 ~-20 ~136 run kill @e[tag=br.matchloot,dx=31,dy=28,dz=16]
function oa:map/internal/tiles/release/95
function oa:map/internal/delete/advance
