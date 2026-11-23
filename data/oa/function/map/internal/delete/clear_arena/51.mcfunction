# BR専用5次元の生成範囲Y=0..160。各fillは32768ブロック以下。
fill ~-120 0 ~8 ~-89 31 ~39 minecraft:air
fill ~-120 32 ~8 ~-89 63 ~39 minecraft:air
fill ~-120 64 ~8 ~-89 95 ~39 minecraft:air
fill ~-120 96 ~8 ~-89 127 ~39 minecraft:air
fill ~-120 128 ~8 ~-89 159 ~39 minecraft:air
fill ~-120 160 ~8 ~-89 160 ~39 minecraft:air
execute positioned ~-120 0 ~8 run kill @e[tag=br.chest,dx=31,dy=160,dz=31]
execute positioned ~-120 0 ~8 run kill @e[tag=br.ore,dx=31,dy=160,dz=31]
execute positioned ~-120 0 ~8 run kill @e[tag=br.matchloot,dx=31,dy=160,dz=31]
execute positioned ~-120 0 ~8 run kill @e[tag=br.supply_wait,dx=31,dy=160,dz=31]
execute positioned ~-120 0 ~8 run kill @e[tag=br.supply_crate,dx=31,dy=160,dz=31]
execute positioned ~-120 0 ~8 run kill @e[tag=oa.gim,dx=31,dy=160,dz=31]
execute positioned ~-120 0 ~8 run kill @e[tag=oa.mdeco,dx=31,dy=160,dz=31]
execute positioned ~-120 0 ~8 run kill @e[tag=oa.isle,dx=31,dy=160,dz=31]
