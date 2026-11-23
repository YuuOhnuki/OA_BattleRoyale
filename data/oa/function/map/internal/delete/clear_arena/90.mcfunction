# BR専用5次元の生成範囲Y=0..160。各fillは32768ブロック以下。
fill ~-152 0 ~136 ~-121 31 ~152 minecraft:air
fill ~-152 32 ~136 ~-121 63 ~152 minecraft:air
fill ~-152 64 ~136 ~-121 95 ~152 minecraft:air
fill ~-152 96 ~136 ~-121 127 ~152 minecraft:air
fill ~-152 128 ~136 ~-121 159 ~152 minecraft:air
fill ~-152 160 ~136 ~-121 160 ~152 minecraft:air
execute positioned ~-152 0 ~136 run kill @e[tag=br.chest,dx=31,dy=160,dz=16]
execute positioned ~-152 0 ~136 run kill @e[tag=br.ore,dx=31,dy=160,dz=16]
execute positioned ~-152 0 ~136 run kill @e[tag=br.matchloot,dx=31,dy=160,dz=16]
execute positioned ~-152 0 ~136 run kill @e[tag=br.supply_wait,dx=31,dy=160,dz=16]
execute positioned ~-152 0 ~136 run kill @e[tag=br.supply_crate,dx=31,dy=160,dz=16]
execute positioned ~-152 0 ~136 run kill @e[tag=oa.gim,dx=31,dy=160,dz=16]
execute positioned ~-152 0 ~136 run kill @e[tag=oa.mdeco,dx=31,dy=160,dz=16]
execute positioned ~-152 0 ~136 run kill @e[tag=oa.isle,dx=31,dy=160,dz=16]
