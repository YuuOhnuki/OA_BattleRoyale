fill ~136 ~-20 ~8 ~152 ~0 ~39 minecraft:air
execute positioned ~136 ~-20 ~8 run kill @e[tag=br.chest,dx=16,dy=28,dz=31]
execute positioned ~136 ~-20 ~8 run kill @e[tag=br.ore,dx=16,dy=28,dz=31]
execute positioned ~136 ~-20 ~8 run kill @e[tag=br.matchloot,dx=16,dy=28,dz=31]
function oa:map/internal/tiles/release/59
function oa:map/internal/delete/advance
