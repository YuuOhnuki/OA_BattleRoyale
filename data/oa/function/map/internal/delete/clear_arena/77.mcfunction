# BR専用5次元の生成範囲Y=0..160。各fillは32768ブロック以下。
fill ~72 0 ~72 ~103 31 ~103 minecraft:air
fill ~72 32 ~72 ~103 63 ~103 minecraft:air
fill ~72 64 ~72 ~103 95 ~103 minecraft:air
fill ~72 96 ~72 ~103 127 ~103 minecraft:air
fill ~72 128 ~72 ~103 159 ~103 minecraft:air
fill ~72 160 ~72 ~103 160 ~103 minecraft:air
execute positioned ~72 0 ~72 run kill @e[tag=br.chest,dx=31,dy=160,dz=31]
execute positioned ~72 0 ~72 run kill @e[tag=br.ore,dx=31,dy=160,dz=31]
execute positioned ~72 0 ~72 run kill @e[tag=br.matchloot,dx=31,dy=160,dz=31]
execute positioned ~72 0 ~72 run kill @e[tag=br.supply_wait,dx=31,dy=160,dz=31]
execute positioned ~72 0 ~72 run kill @e[tag=br.supply_crate,dx=31,dy=160,dz=31]
execute positioned ~72 0 ~72 run kill @e[tag=oa.gim,dx=31,dy=160,dz=31]
execute positioned ~72 0 ~72 run kill @e[tag=oa.mdeco,dx=31,dy=160,dz=31]
execute positioned ~72 0 ~72 run kill @e[tag=oa.isle,dx=31,dy=160,dz=31]
