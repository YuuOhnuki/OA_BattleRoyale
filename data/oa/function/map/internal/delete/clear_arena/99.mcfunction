# BR専用5次元の生成範囲Y=0..160。各fillは32768ブロック以下。
fill ~136 0 ~136 ~152 31 ~152 minecraft:air
fill ~136 32 ~136 ~152 63 ~152 minecraft:air
fill ~136 64 ~136 ~152 95 ~152 minecraft:air
fill ~136 96 ~136 ~152 127 ~152 minecraft:air
fill ~136 128 ~136 ~152 159 ~152 minecraft:air
fill ~136 160 ~136 ~152 160 ~152 minecraft:air
execute positioned ~136 0 ~136 run kill @e[tag=br.chest,dx=16,dy=160,dz=16]
execute positioned ~136 0 ~136 run kill @e[tag=br.ore,dx=16,dy=160,dz=16]
execute positioned ~136 0 ~136 run kill @e[tag=br.matchloot,dx=16,dy=160,dz=16]
execute positioned ~136 0 ~136 run kill @e[tag=br.supply_wait,dx=16,dy=160,dz=16]
execute positioned ~136 0 ~136 run kill @e[tag=br.supply_crate,dx=16,dy=160,dz=16]
execute positioned ~136 0 ~136 run kill @e[tag=oa.gim,dx=16,dy=160,dz=16]
execute positioned ~136 0 ~136 run kill @e[tag=oa.mdeco,dx=16,dy=160,dz=16]
execute positioned ~136 0 ~136 run kill @e[tag=oa.isle,dx=16,dy=160,dz=16]
