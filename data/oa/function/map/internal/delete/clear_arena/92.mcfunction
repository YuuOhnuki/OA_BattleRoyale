# BR専用5次元の生成範囲Y=0..160。各fillは32768ブロック以下。
fill ~-88 0 ~136 ~-57 31 ~152 minecraft:air
fill ~-88 32 ~136 ~-57 63 ~152 minecraft:air
fill ~-88 64 ~136 ~-57 95 ~152 minecraft:air
fill ~-88 96 ~136 ~-57 127 ~152 minecraft:air
fill ~-88 128 ~136 ~-57 159 ~152 minecraft:air
fill ~-88 160 ~136 ~-57 160 ~152 minecraft:air
execute positioned ~-88 0 ~136 run kill @e[tag=br.chest,dx=31,dy=160,dz=16]
execute positioned ~-88 0 ~136 run kill @e[tag=br.ore,dx=31,dy=160,dz=16]
execute positioned ~-88 0 ~136 run kill @e[tag=br.matchloot,dx=31,dy=160,dz=16]
execute positioned ~-88 0 ~136 run kill @e[tag=br.supply_wait,dx=31,dy=160,dz=16]
execute positioned ~-88 0 ~136 run kill @e[tag=br.supply_crate,dx=31,dy=160,dz=16]
execute positioned ~-88 0 ~136 run kill @e[tag=oa.gim,dx=31,dy=160,dz=16]
execute positioned ~-88 0 ~136 run kill @e[tag=oa.mdeco,dx=31,dy=160,dz=16]
execute positioned ~-88 0 ~136 run kill @e[tag=oa.isle,dx=31,dy=160,dz=16]
