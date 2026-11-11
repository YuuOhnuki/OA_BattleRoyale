fill ~-88 ~-20 ~-24 ~-57 ~0 ~7 minecraft:air
execute positioned ~-88 ~-20 ~-24 run kill @e[tag=br.chest,dx=31,dy=28,dz=31]
execute positioned ~-88 ~-20 ~-24 run kill @e[tag=br.ore,dx=31,dy=28,dz=31]
execute positioned ~-88 ~-20 ~-24 run kill @e[tag=br.matchloot,dx=31,dy=28,dz=31]
function oa:map/internal/tiles/release/42
function oa:map/internal/delete/advance
