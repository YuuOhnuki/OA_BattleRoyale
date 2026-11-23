# BR専用5次元の生成範囲Y=0..160。各fillは32768ブロック以下。
fill ~-24 0 ~104 ~7 31 ~135 minecraft:air
fill ~-24 32 ~104 ~7 63 ~135 minecraft:air
fill ~-24 64 ~104 ~7 95 ~135 minecraft:air
fill ~-24 96 ~104 ~7 127 ~135 minecraft:air
fill ~-24 128 ~104 ~7 159 ~135 minecraft:air
fill ~-24 160 ~104 ~7 160 ~135 minecraft:air
execute positioned ~-24 0 ~104 run kill @e[tag=br.chest,dx=31,dy=160,dz=31]
execute positioned ~-24 0 ~104 run kill @e[tag=br.ore,dx=31,dy=160,dz=31]
execute positioned ~-24 0 ~104 run kill @e[tag=br.matchloot,dx=31,dy=160,dz=31]
execute positioned ~-24 0 ~104 run kill @e[tag=br.supply_wait,dx=31,dy=160,dz=31]
execute positioned ~-24 0 ~104 run kill @e[tag=br.supply_crate,dx=31,dy=160,dz=31]
execute positioned ~-24 0 ~104 run kill @e[tag=oa.gim,dx=31,dy=160,dz=31]
execute positioned ~-24 0 ~104 run kill @e[tag=oa.mdeco,dx=31,dy=160,dz=31]
execute positioned ~-24 0 ~104 run kill @e[tag=oa.isle,dx=31,dy=160,dz=31]
