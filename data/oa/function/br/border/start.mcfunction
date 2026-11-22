execute if score #map oa.mapid matches 0 in oa:br store result storage oa:br border_restore.size int 1 run worldborder get
execute if score #map oa.mapid matches 1 in oa:br_nether store result storage oa:br border_restore.size int 1 run worldborder get
execute if score #map oa.mapid matches 2 in oa:br_cave store result storage oa:br border_restore.size int 1 run worldborder get
execute if score #map oa.mapid matches 3 in oa:br_sky store result storage oa:br border_restore.size int 1 run worldborder get
execute if score #map oa.mapid matches 4 in oa:br_end store result storage oa:br border_restore.size int 1 run worldborder get
execute if score #map oa.mapid matches 0 in oa:br run function oa:br/border/center with storage oa:br center
execute if score #map oa.mapid matches 1 in oa:br_nether run function oa:br/border/center with storage oa:br center
execute if score #map oa.mapid matches 2 in oa:br_cave run function oa:br/border/center with storage oa:br center
execute if score #map oa.mapid matches 3 in oa:br_sky run function oa:br/border/center with storage oa:br center
execute if score #map oa.mapid matches 4 in oa:br_end run function oa:br/border/center with storage oa:br center
execute if score #map oa.mapid matches 0 in oa:br run worldborder set 300
execute if score #map oa.mapid matches 1 in oa:br_nether run worldborder set 300
execute if score #map oa.mapid matches 2 in oa:br_cave run worldborder set 300
execute if score #map oa.mapid matches 3 in oa:br_sky run worldborder set 300
execute if score #map oa.mapid matches 4 in oa:br_end run worldborder set 300
execute if score #map oa.mapid matches 0 in oa:br run worldborder damage amount 0
execute if score #map oa.mapid matches 1 in oa:br_nether run worldborder damage amount 0
execute if score #map oa.mapid matches 2 in oa:br_cave run worldborder damage amount 0
execute if score #map oa.mapid matches 3 in oa:br_sky run worldborder damage amount 0
execute if score #map oa.mapid matches 4 in oa:br_end run worldborder damage amount 0
scoreboard players set #sec br.sec 0
# 1.9.218: 安全地帯の値（#zr・#half・#zcx など）はプラグインが書く。半径215で始まる
scoreboard players set #half br.tmp 215000
scoreboard players set #zrb br.tmp 215
scoreboard players set #phase br.tmp 0
scoreboard players set #shrinking br.flag 0
scoreboard players operation #alive br.live = #players br.tmp
