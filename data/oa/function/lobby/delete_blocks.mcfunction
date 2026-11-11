fill ~-40 ~-3 ~-40 ~40 ~0 ~40 minecraft:air
fill ~-40 ~1 ~-40 ~40 ~4 ~40 minecraft:air
fill ~-40 ~5 ~-40 ~40 ~8 ~40 minecraft:air
fill ~-40 ~9 ~-40 ~40 ~12 ~40 minecraft:air
fill ~-40 ~13 ~-40 ~40 ~16 ~40 minecraft:air
fill ~-40 ~17 ~-40 ~40 ~20 ~40 minecraft:air
fill ~-40 ~21 ~-40 ~40 ~24 ~40 minecraft:air
fill ~-40 ~25 ~-40 ~40 ~28 ~40 minecraft:air
fill ~-40 ~29 ~-40 ~40 ~32 ~40 minecraft:air
fill ~-40 ~33 ~-40 ~40 ~36 ~40 minecraft:air
fill ~-40 ~37 ~-40 ~40 ~40 ~40 minecraft:air
fill ~-40 ~41 ~-40 ~40 ~44 ~40 minecraft:air
execute positioned ~-40 ~-3 ~-40 run kill @e[tag=oa.lobby_label,dx=80,dy=47,dz=80]
execute positioned ~-40 ~-3 ~-40 run kill @e[tag=oa.lobby_exhibit,dx=80,dy=47,dz=80]
execute positioned ~-40 ~-3 ~-40 run kill @e[tag=oa.gallery,dx=80,dy=47,dz=80]
execute positioned ~-40 ~-3 ~-40 run kill @e[tag=oa.exhibit_pichipichi,dx=80,dy=47,dz=80]
execute if score #l0 oa.tmp matches 0 run forceload remove ~-40 ~-40
execute if score #l1 oa.tmp matches 0 run forceload remove ~-40 ~-24
execute if score #l2 oa.tmp matches 0 run forceload remove ~-40 ~-8
execute if score #l3 oa.tmp matches 0 run forceload remove ~-40 ~8
execute if score #l4 oa.tmp matches 0 run forceload remove ~-40 ~24
execute if score #l5 oa.tmp matches 0 run forceload remove ~-40 ~40
execute if score #l6 oa.tmp matches 0 run forceload remove ~-24 ~-40
execute if score #l7 oa.tmp matches 0 run forceload remove ~-24 ~-24
execute if score #l8 oa.tmp matches 0 run forceload remove ~-24 ~-8
execute if score #l9 oa.tmp matches 0 run forceload remove ~-24 ~8
execute if score #l10 oa.tmp matches 0 run forceload remove ~-24 ~24
execute if score #l11 oa.tmp matches 0 run forceload remove ~-24 ~40
execute if score #l12 oa.tmp matches 0 run forceload remove ~-8 ~-40
execute if score #l13 oa.tmp matches 0 run forceload remove ~-8 ~-24
execute if score #l14 oa.tmp matches 0 run forceload remove ~-8 ~-8
execute if score #l15 oa.tmp matches 0 run forceload remove ~-8 ~8
execute if score #l16 oa.tmp matches 0 run forceload remove ~-8 ~24
execute if score #l17 oa.tmp matches 0 run forceload remove ~-8 ~40
execute if score #l18 oa.tmp matches 0 run forceload remove ~8 ~-40
execute if score #l19 oa.tmp matches 0 run forceload remove ~8 ~-24
execute if score #l20 oa.tmp matches 0 run forceload remove ~8 ~-8
execute if score #l21 oa.tmp matches 0 run forceload remove ~8 ~8
execute if score #l22 oa.tmp matches 0 run forceload remove ~8 ~24
execute if score #l23 oa.tmp matches 0 run forceload remove ~8 ~40
execute if score #l24 oa.tmp matches 0 run forceload remove ~24 ~-40
execute if score #l25 oa.tmp matches 0 run forceload remove ~24 ~-24
execute if score #l26 oa.tmp matches 0 run forceload remove ~24 ~-8
execute if score #l27 oa.tmp matches 0 run forceload remove ~24 ~8
execute if score #l28 oa.tmp matches 0 run forceload remove ~24 ~24
execute if score #l29 oa.tmp matches 0 run forceload remove ~24 ~40
execute if score #l30 oa.tmp matches 0 run forceload remove ~40 ~-40
execute if score #l31 oa.tmp matches 0 run forceload remove ~40 ~-24
execute if score #l32 oa.tmp matches 0 run forceload remove ~40 ~-8
execute if score #l33 oa.tmp matches 0 run forceload remove ~40 ~8
execute if score #l34 oa.tmp matches 0 run forceload remove ~40 ~24
execute if score #l35 oa.tmp matches 0 run forceload remove ~40 ~40
data remove storage oa:lobby origin
function oa:lobby/job_finish
