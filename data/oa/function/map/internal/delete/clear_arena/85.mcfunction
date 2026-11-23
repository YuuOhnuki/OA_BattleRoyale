# BR専用5次元の生成範囲Y=0..160。各fillは32768ブロック以下。
fill ~8 0 ~104 ~39 31 ~135 minecraft:air
fill ~8 32 ~104 ~39 63 ~135 minecraft:air
fill ~8 64 ~104 ~39 95 ~135 minecraft:air
fill ~8 96 ~104 ~39 127 ~135 minecraft:air
fill ~8 128 ~104 ~39 159 ~135 minecraft:air
fill ~8 160 ~104 ~39 160 ~135 minecraft:air
execute positioned ~8 0 ~104 run kill @e[tag=br.chest,dx=31,dy=160,dz=31]
execute positioned ~8 0 ~104 run kill @e[tag=br.ore,dx=31,dy=160,dz=31]
execute positioned ~8 0 ~104 run kill @e[tag=br.matchloot,dx=31,dy=160,dz=31]
execute positioned ~8 0 ~104 run kill @e[tag=br.supply_wait,dx=31,dy=160,dz=31]
execute positioned ~8 0 ~104 run kill @e[tag=br.supply_crate,dx=31,dy=160,dz=31]
execute positioned ~8 0 ~104 run kill @e[tag=oa.gim,dx=31,dy=160,dz=31]
execute positioned ~8 0 ~104 run kill @e[tag=oa.mdeco,dx=31,dy=160,dz=31]
execute positioned ~8 0 ~104 run kill @e[tag=oa.isle,dx=31,dy=160,dz=31]
