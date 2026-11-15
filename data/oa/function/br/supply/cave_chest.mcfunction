# 1.9.186: 洞窟の補給で良い場所が見つからなかったとき（補給のマーカーとして）。範囲内のランダムな通常チェストの横の床へ。
# チェストは部屋・通路の床にあるので、横の空いた場所に置く（天井が低いと、吊り下ろす箱が天井に重なって見えることがある）
$execute positioned $(x) $(y) $(z) as @e[type=minecraft:marker,tag=br.chest,tag=!br.rich,distance=..$(range),sort=random,limit=1] at @s run tag @s add br.sup_pick
execute unless entity @e[type=minecraft:marker,tag=br.sup_pick] run return 0
tp @s @e[type=minecraft:marker,tag=br.sup_pick,limit=1]
tag @e[type=minecraft:marker,tag=br.sup_pick] remove br.sup_pick
execute at @s if block ~1 ~ ~ #oa:spawn_clear if block ~1 ~1 ~ #oa:spawn_clear unless block ~1 ~-1 ~ #oa:spawn_clear run return run function oa:br/supply/cave_chest_ok {dx:1,dz:0}
execute at @s if block ~-1 ~ ~ #oa:spawn_clear if block ~-1 ~1 ~ #oa:spawn_clear unless block ~-1 ~-1 ~ #oa:spawn_clear run return run function oa:br/supply/cave_chest_ok {dx:-1,dz:0}
execute at @s if block ~ ~ ~1 #oa:spawn_clear if block ~ ~1 ~1 #oa:spawn_clear unless block ~ ~-1 ~1 #oa:spawn_clear run return run function oa:br/supply/cave_chest_ok {dx:0,dz:1}
execute at @s if block ~ ~ ~-1 #oa:spawn_clear if block ~ ~1 ~-1 #oa:spawn_clear unless block ~ ~-1 ~-1 #oa:spawn_clear run return run function oa:br/supply/cave_chest_ok {dx:0,dz:-1}
