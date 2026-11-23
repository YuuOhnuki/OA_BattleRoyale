# BR専用5次元の生成範囲Y=0..160。各fillは32768ブロック以下。
fill ~136 0 ~40 ~152 31 ~71 minecraft:air
fill ~136 32 ~40 ~152 63 ~71 minecraft:air
fill ~136 64 ~40 ~152 95 ~71 minecraft:air
fill ~136 96 ~40 ~152 127 ~71 minecraft:air
fill ~136 128 ~40 ~152 159 ~71 minecraft:air
fill ~136 160 ~40 ~152 160 ~71 minecraft:air
execute positioned ~136 0 ~40 run kill @e[tag=br.chest,dx=16,dy=160,dz=31]
execute positioned ~136 0 ~40 run kill @e[tag=br.ore,dx=16,dy=160,dz=31]
execute positioned ~136 0 ~40 run kill @e[tag=br.matchloot,dx=16,dy=160,dz=31]
execute positioned ~136 0 ~40 run kill @e[tag=br.supply_wait,dx=16,dy=160,dz=31]
execute positioned ~136 0 ~40 run kill @e[tag=br.supply_crate,dx=16,dy=160,dz=31]
execute positioned ~136 0 ~40 run kill @e[tag=oa.gim,dx=16,dy=160,dz=31]
execute positioned ~136 0 ~40 run kill @e[tag=oa.mdeco,dx=16,dy=160,dz=31]
execute positioned ~136 0 ~40 run kill @e[tag=oa.isle,dx=16,dy=160,dz=31]
