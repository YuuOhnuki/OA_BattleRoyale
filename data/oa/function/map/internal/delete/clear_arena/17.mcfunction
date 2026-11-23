# BR専用5次元の生成範囲Y=0..160。各fillは32768ブロック以下。
fill ~72 0 ~-120 ~103 31 ~-89 minecraft:air
fill ~72 32 ~-120 ~103 63 ~-89 minecraft:air
fill ~72 64 ~-120 ~103 95 ~-89 minecraft:air
fill ~72 96 ~-120 ~103 127 ~-89 minecraft:air
fill ~72 128 ~-120 ~103 159 ~-89 minecraft:air
fill ~72 160 ~-120 ~103 160 ~-89 minecraft:air
execute positioned ~72 0 ~-120 run kill @e[tag=br.chest,dx=31,dy=160,dz=31]
execute positioned ~72 0 ~-120 run kill @e[tag=br.ore,dx=31,dy=160,dz=31]
execute positioned ~72 0 ~-120 run kill @e[tag=br.matchloot,dx=31,dy=160,dz=31]
execute positioned ~72 0 ~-120 run kill @e[tag=br.supply_wait,dx=31,dy=160,dz=31]
execute positioned ~72 0 ~-120 run kill @e[tag=br.supply_crate,dx=31,dy=160,dz=31]
execute positioned ~72 0 ~-120 run kill @e[tag=oa.gim,dx=31,dy=160,dz=31]
execute positioned ~72 0 ~-120 run kill @e[tag=oa.mdeco,dx=31,dy=160,dz=31]
execute positioned ~72 0 ~-120 run kill @e[tag=oa.isle,dx=31,dy=160,dz=31]
