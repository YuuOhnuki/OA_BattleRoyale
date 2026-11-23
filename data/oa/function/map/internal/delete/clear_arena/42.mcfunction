# BR専用5次元の生成範囲Y=0..160。各fillは32768ブロック以下。
fill ~-88 0 ~-24 ~-57 31 ~7 minecraft:air
fill ~-88 32 ~-24 ~-57 63 ~7 minecraft:air
fill ~-88 64 ~-24 ~-57 95 ~7 minecraft:air
fill ~-88 96 ~-24 ~-57 127 ~7 minecraft:air
fill ~-88 128 ~-24 ~-57 159 ~7 minecraft:air
fill ~-88 160 ~-24 ~-57 160 ~7 minecraft:air
execute positioned ~-88 0 ~-24 run kill @e[tag=br.chest,dx=31,dy=160,dz=31]
execute positioned ~-88 0 ~-24 run kill @e[tag=br.ore,dx=31,dy=160,dz=31]
execute positioned ~-88 0 ~-24 run kill @e[tag=br.matchloot,dx=31,dy=160,dz=31]
execute positioned ~-88 0 ~-24 run kill @e[tag=br.supply_wait,dx=31,dy=160,dz=31]
execute positioned ~-88 0 ~-24 run kill @e[tag=br.supply_crate,dx=31,dy=160,dz=31]
execute positioned ~-88 0 ~-24 run kill @e[tag=oa.gim,dx=31,dy=160,dz=31]
execute positioned ~-88 0 ~-24 run kill @e[tag=oa.mdeco,dx=31,dy=160,dz=31]
execute positioned ~-88 0 ~-24 run kill @e[tag=oa.isle,dx=31,dy=160,dz=31]
