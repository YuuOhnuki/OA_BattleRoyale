# BR専用5次元の生成範囲Y=0..160。各fillは32768ブロック以下。
fill ~-120 0 ~136 ~-89 31 ~152 minecraft:air
fill ~-120 32 ~136 ~-89 63 ~152 minecraft:air
fill ~-120 64 ~136 ~-89 95 ~152 minecraft:air
fill ~-120 96 ~136 ~-89 127 ~152 minecraft:air
fill ~-120 128 ~136 ~-89 159 ~152 minecraft:air
fill ~-120 160 ~136 ~-89 160 ~152 minecraft:air
execute positioned ~-120 0 ~136 run kill @e[tag=br.chest,dx=31,dy=160,dz=16]
execute positioned ~-120 0 ~136 run kill @e[tag=br.ore,dx=31,dy=160,dz=16]
execute positioned ~-120 0 ~136 run kill @e[tag=br.matchloot,dx=31,dy=160,dz=16]
execute positioned ~-120 0 ~136 run kill @e[tag=br.supply_wait,dx=31,dy=160,dz=16]
execute positioned ~-120 0 ~136 run kill @e[tag=br.supply_crate,dx=31,dy=160,dz=16]
execute positioned ~-120 0 ~136 run kill @e[tag=oa.gim,dx=31,dy=160,dz=16]
execute positioned ~-120 0 ~136 run kill @e[tag=oa.mdeco,dx=31,dy=160,dz=16]
execute positioned ~-120 0 ~136 run kill @e[tag=oa.isle,dx=31,dy=160,dz=16]
