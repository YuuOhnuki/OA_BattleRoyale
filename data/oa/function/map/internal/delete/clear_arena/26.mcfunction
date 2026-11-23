# BR専用5次元の生成範囲Y=0..160。各fillは32768ブロック以下。
fill ~40 0 ~-88 ~71 31 ~-57 minecraft:air
fill ~40 32 ~-88 ~71 63 ~-57 minecraft:air
fill ~40 64 ~-88 ~71 95 ~-57 minecraft:air
fill ~40 96 ~-88 ~71 127 ~-57 minecraft:air
fill ~40 128 ~-88 ~71 159 ~-57 minecraft:air
fill ~40 160 ~-88 ~71 160 ~-57 minecraft:air
execute positioned ~40 0 ~-88 run kill @e[tag=br.chest,dx=31,dy=160,dz=31]
execute positioned ~40 0 ~-88 run kill @e[tag=br.ore,dx=31,dy=160,dz=31]
execute positioned ~40 0 ~-88 run kill @e[tag=br.matchloot,dx=31,dy=160,dz=31]
execute positioned ~40 0 ~-88 run kill @e[tag=br.supply_wait,dx=31,dy=160,dz=31]
execute positioned ~40 0 ~-88 run kill @e[tag=br.supply_crate,dx=31,dy=160,dz=31]
execute positioned ~40 0 ~-88 run kill @e[tag=oa.gim,dx=31,dy=160,dz=31]
execute positioned ~40 0 ~-88 run kill @e[tag=oa.mdeco,dx=31,dy=160,dz=31]
execute positioned ~40 0 ~-88 run kill @e[tag=oa.isle,dx=31,dy=160,dz=31]
