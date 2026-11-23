# BR専用5次元の生成範囲Y=0..160。各fillは32768ブロック以下。
fill ~8 0 ~-24 ~39 31 ~7 minecraft:air
fill ~8 32 ~-24 ~39 63 ~7 minecraft:air
fill ~8 64 ~-24 ~39 95 ~7 minecraft:air
fill ~8 96 ~-24 ~39 127 ~7 minecraft:air
fill ~8 128 ~-24 ~39 159 ~7 minecraft:air
fill ~8 160 ~-24 ~39 160 ~7 minecraft:air
execute positioned ~8 0 ~-24 run kill @e[tag=br.chest,dx=31,dy=160,dz=31]
execute positioned ~8 0 ~-24 run kill @e[tag=br.ore,dx=31,dy=160,dz=31]
execute positioned ~8 0 ~-24 run kill @e[tag=br.matchloot,dx=31,dy=160,dz=31]
execute positioned ~8 0 ~-24 run kill @e[tag=br.supply_wait,dx=31,dy=160,dz=31]
execute positioned ~8 0 ~-24 run kill @e[tag=br.supply_crate,dx=31,dy=160,dz=31]
execute positioned ~8 0 ~-24 run kill @e[tag=oa.gim,dx=31,dy=160,dz=31]
execute positioned ~8 0 ~-24 run kill @e[tag=oa.mdeco,dx=31,dy=160,dz=31]
execute positioned ~8 0 ~-24 run kill @e[tag=oa.isle,dx=31,dy=160,dz=31]
