# BR専用5次元の生成範囲Y=0..160。各fillは32768ブロック以下。
fill ~-152 0 ~8 ~-121 31 ~39 minecraft:air
fill ~-152 32 ~8 ~-121 63 ~39 minecraft:air
fill ~-152 64 ~8 ~-121 95 ~39 minecraft:air
fill ~-152 96 ~8 ~-121 127 ~39 minecraft:air
fill ~-152 128 ~8 ~-121 159 ~39 minecraft:air
fill ~-152 160 ~8 ~-121 160 ~39 minecraft:air
execute positioned ~-152 0 ~8 run kill @e[tag=br.chest,dx=31,dy=160,dz=31]
execute positioned ~-152 0 ~8 run kill @e[tag=br.ore,dx=31,dy=160,dz=31]
execute positioned ~-152 0 ~8 run kill @e[tag=br.matchloot,dx=31,dy=160,dz=31]
execute positioned ~-152 0 ~8 run kill @e[tag=br.supply_wait,dx=31,dy=160,dz=31]
execute positioned ~-152 0 ~8 run kill @e[tag=br.supply_crate,dx=31,dy=160,dz=31]
execute positioned ~-152 0 ~8 run kill @e[tag=oa.gim,dx=31,dy=160,dz=31]
execute positioned ~-152 0 ~8 run kill @e[tag=oa.mdeco,dx=31,dy=160,dz=31]
execute positioned ~-152 0 ~8 run kill @e[tag=oa.isle,dx=31,dy=160,dz=31]
