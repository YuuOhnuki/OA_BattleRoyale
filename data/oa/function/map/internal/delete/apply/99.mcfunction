fill ~136 ~-20 ~136 ~152 ~0 ~152 minecraft:air
execute positioned ~136 ~-20 ~136 run kill @e[tag=br.chest,dx=16,dy=28,dz=16]
execute positioned ~136 ~-20 ~136 run kill @e[tag=br.ore,dx=16,dy=28,dz=16]
execute positioned ~136 ~-20 ~136 run kill @e[tag=br.matchloot,dx=16,dy=28,dz=16]
function oa:map/internal/tiles/release/99
function oa:map/internal/delete/advance
