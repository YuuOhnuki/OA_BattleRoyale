# BR専用5次元の生成範囲Y=0..160。各fillは32768ブロック以下。
fill ~8 0 ~40 ~39 31 ~71 minecraft:air
fill ~8 32 ~40 ~39 63 ~71 minecraft:air
fill ~8 64 ~40 ~39 95 ~71 minecraft:air
fill ~8 96 ~40 ~39 127 ~71 minecraft:air
fill ~8 128 ~40 ~39 159 ~71 minecraft:air
fill ~8 160 ~40 ~39 160 ~71 minecraft:air
execute positioned ~8 0 ~40 run kill @e[tag=br.chest,dx=31,dy=160,dz=31]
execute positioned ~8 0 ~40 run kill @e[tag=br.ore,dx=31,dy=160,dz=31]
execute positioned ~8 0 ~40 run kill @e[tag=br.matchloot,dx=31,dy=160,dz=31]
execute positioned ~8 0 ~40 run kill @e[tag=br.supply_wait,dx=31,dy=160,dz=31]
execute positioned ~8 0 ~40 run kill @e[tag=br.supply_crate,dx=31,dy=160,dz=31]
execute positioned ~8 0 ~40 run kill @e[tag=oa.gim,dx=31,dy=160,dz=31]
execute positioned ~8 0 ~40 run kill @e[tag=oa.mdeco,dx=31,dy=160,dz=31]
execute positioned ~8 0 ~40 run kill @e[tag=oa.isle,dx=31,dy=160,dz=31]
