execute if score #half br.tmp matches ..5000 run return 0
data modify storage oa:br_spawn x set from storage oa:br center.x
data modify storage oa:br_spawn z set from storage oa:br center.z
data modify storage oa:br_spawn y set from storage oa:br center.y
# 1.9.160: 落下地点は「次の縮小が終わったあとのエリア」の内側（端から10ブロック内側）から選ぶ。
# 1.9.161: 予告は縮小のない時間（tick 3900・6300・8700）に移した。第1便は一辺160、第2便・第3便は一辺90の内側
scoreboard players operation #range br.tmp = #half br.tmp
execute if score #time br.time matches ..6299 run scoreboard players set #range br.tmp 80000
execute if score #time br.time matches 6300..10799 run scoreboard players set #range br.tmp 45000
scoreboard players operation #range br.tmp /= #1000 br.tmp
scoreboard players remove #range br.tmp 10
execute if score #range br.tmp matches ..4 run scoreboard players set #range br.tmp 5
execute store result storage oa:br_spawn range int 1 run scoreboard players get #range br.tmp
execute if score #map oa.mapid matches 0 in oa:br run function oa:br/supply/place with storage oa:br_spawn
execute if score #map oa.mapid matches 1 in oa:br_nether run function oa:br/supply/place with storage oa:br_spawn
