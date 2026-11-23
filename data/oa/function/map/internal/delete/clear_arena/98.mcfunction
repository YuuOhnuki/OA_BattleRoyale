# BR専用5次元の生成範囲Y=0..160。各fillは32768ブロック以下。
fill ~104 0 ~136 ~135 31 ~152 minecraft:air
fill ~104 32 ~136 ~135 63 ~152 minecraft:air
fill ~104 64 ~136 ~135 95 ~152 minecraft:air
fill ~104 96 ~136 ~135 127 ~152 minecraft:air
fill ~104 128 ~136 ~135 159 ~152 minecraft:air
fill ~104 160 ~136 ~135 160 ~152 minecraft:air
execute positioned ~104 0 ~136 run kill @e[tag=br.chest,dx=31,dy=160,dz=16]
execute positioned ~104 0 ~136 run kill @e[tag=br.ore,dx=31,dy=160,dz=16]
execute positioned ~104 0 ~136 run kill @e[tag=br.matchloot,dx=31,dy=160,dz=16]
execute positioned ~104 0 ~136 run kill @e[tag=br.supply_wait,dx=31,dy=160,dz=16]
execute positioned ~104 0 ~136 run kill @e[tag=br.supply_crate,dx=31,dy=160,dz=16]
execute positioned ~104 0 ~136 run kill @e[tag=oa.gim,dx=31,dy=160,dz=16]
execute positioned ~104 0 ~136 run kill @e[tag=oa.mdeco,dx=31,dy=160,dz=16]
execute positioned ~104 0 ~136 run kill @e[tag=oa.isle,dx=31,dy=160,dz=16]
