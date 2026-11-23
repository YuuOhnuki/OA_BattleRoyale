# BR専用5次元の生成範囲Y=0..160。各fillは32768ブロック以下。
fill ~40 0 ~-24 ~71 31 ~7 minecraft:air
fill ~40 32 ~-24 ~71 63 ~7 minecraft:air
fill ~40 64 ~-24 ~71 95 ~7 minecraft:air
fill ~40 96 ~-24 ~71 127 ~7 minecraft:air
fill ~40 128 ~-24 ~71 159 ~7 minecraft:air
fill ~40 160 ~-24 ~71 160 ~7 minecraft:air
execute positioned ~40 0 ~-24 run kill @e[tag=br.chest,dx=31,dy=160,dz=31]
execute positioned ~40 0 ~-24 run kill @e[tag=br.ore,dx=31,dy=160,dz=31]
execute positioned ~40 0 ~-24 run kill @e[tag=br.matchloot,dx=31,dy=160,dz=31]
execute positioned ~40 0 ~-24 run kill @e[tag=br.supply_wait,dx=31,dy=160,dz=31]
execute positioned ~40 0 ~-24 run kill @e[tag=br.supply_crate,dx=31,dy=160,dz=31]
execute positioned ~40 0 ~-24 run kill @e[tag=oa.gim,dx=31,dy=160,dz=31]
execute positioned ~40 0 ~-24 run kill @e[tag=oa.mdeco,dx=31,dy=160,dz=31]
execute positioned ~40 0 ~-24 run kill @e[tag=oa.isle,dx=31,dy=160,dz=31]
