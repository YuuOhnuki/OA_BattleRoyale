# BR専用5次元の生成範囲Y=0..160。各fillは32768ブロック以下。
fill ~-120 0 ~-120 ~-89 31 ~-89 minecraft:air
fill ~-120 32 ~-120 ~-89 63 ~-89 minecraft:air
fill ~-120 64 ~-120 ~-89 95 ~-89 minecraft:air
fill ~-120 96 ~-120 ~-89 127 ~-89 minecraft:air
fill ~-120 128 ~-120 ~-89 159 ~-89 minecraft:air
fill ~-120 160 ~-120 ~-89 160 ~-89 minecraft:air
execute positioned ~-120 0 ~-120 run kill @e[tag=br.chest,dx=31,dy=160,dz=31]
execute positioned ~-120 0 ~-120 run kill @e[tag=br.ore,dx=31,dy=160,dz=31]
execute positioned ~-120 0 ~-120 run kill @e[tag=br.matchloot,dx=31,dy=160,dz=31]
execute positioned ~-120 0 ~-120 run kill @e[tag=br.supply_wait,dx=31,dy=160,dz=31]
execute positioned ~-120 0 ~-120 run kill @e[tag=br.supply_crate,dx=31,dy=160,dz=31]
execute positioned ~-120 0 ~-120 run kill @e[tag=oa.gim,dx=31,dy=160,dz=31]
execute positioned ~-120 0 ~-120 run kill @e[tag=oa.mdeco,dx=31,dy=160,dz=31]
execute positioned ~-120 0 ~-120 run kill @e[tag=oa.isle,dx=31,dy=160,dz=31]
