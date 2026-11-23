# BR専用5次元の生成範囲Y=0..160。各fillは32768ブロック以下。
fill ~-56 0 ~136 ~-25 31 ~152 minecraft:air
fill ~-56 32 ~136 ~-25 63 ~152 minecraft:air
fill ~-56 64 ~136 ~-25 95 ~152 minecraft:air
fill ~-56 96 ~136 ~-25 127 ~152 minecraft:air
fill ~-56 128 ~136 ~-25 159 ~152 minecraft:air
fill ~-56 160 ~136 ~-25 160 ~152 minecraft:air
execute positioned ~-56 0 ~136 run kill @e[tag=br.chest,dx=31,dy=160,dz=16]
execute positioned ~-56 0 ~136 run kill @e[tag=br.ore,dx=31,dy=160,dz=16]
execute positioned ~-56 0 ~136 run kill @e[tag=br.matchloot,dx=31,dy=160,dz=16]
execute positioned ~-56 0 ~136 run kill @e[tag=br.supply_wait,dx=31,dy=160,dz=16]
execute positioned ~-56 0 ~136 run kill @e[tag=br.supply_crate,dx=31,dy=160,dz=16]
execute positioned ~-56 0 ~136 run kill @e[tag=oa.gim,dx=31,dy=160,dz=16]
execute positioned ~-56 0 ~136 run kill @e[tag=oa.mdeco,dx=31,dy=160,dz=16]
execute positioned ~-56 0 ~136 run kill @e[tag=oa.isle,dx=31,dy=160,dz=16]
