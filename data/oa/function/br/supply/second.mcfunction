scoreboard players set #sup_on br.tmp 0
execute if score #map oa.mapid matches 0 in oa:br as @e[type=minecraft:marker,tag=br.supply_wait,limit=1] run function oa:br/supply/coords
execute if score #map oa.mapid matches 1 in oa:br_nether as @e[type=minecraft:marker,tag=br.supply_wait,limit=1] run function oa:br/supply/coords
execute if score #map oa.mapid matches 0 in oa:br as @e[type=minecraft:marker,tag=br.supply_fx,scores={br.sup=..60},limit=1] run function oa:br/supply/coords
execute if score #map oa.mapid matches 1 in oa:br_nether as @e[type=minecraft:marker,tag=br.supply_fx,scores={br.sup=..60},limit=1] run function oa:br/supply/coords
execute if score #sup_on br.tmp matches 1 run function oa:br/supply/region
# 1.9.113: 補給物資のアクションバーは3秒ごとに通常のバーと交互に表示（#sup_phase=1 の間だけ補給、0の間は通常）
scoreboard players set #c3 br.tmp 3
scoreboard players set #c2 br.tmp 2
scoreboard players operation #sup_ph br.tmp = #sec br.sec
scoreboard players operation #sup_ph br.tmp /= #c3 br.tmp
scoreboard players operation #sup_ph br.tmp %= #c2 br.tmp
scoreboard players set #sup_phase br.tmp 0
execute if score #sup_on br.tmp matches 1 if score #sup_ph br.tmp matches 0 run scoreboard players set #sup_phase br.tmp 1
execute if score #sup_phase br.tmp matches 1 as @a[tag=br.playing] at @s run function oa:br/supply/guide_bar
execute if score #map oa.mapid matches 0 in oa:br as @e[type=minecraft:marker,tag=br.supply_wait] at @s run particle minecraft:end_rod ~ ~2 ~ 0.15 6 0.15 0.01 24 force @a[tag=br.playing,distance=..160]
execute if score #map oa.mapid matches 1 in oa:br_nether as @e[type=minecraft:marker,tag=br.supply_wait] at @s run particle minecraft:end_rod ~ ~2 ~ 0.15 6 0.15 0.01 24 force @a[tag=br.playing,distance=..160]
