execute if score #half br.tmp matches ..5000 run return 0
# 1.9.218: 中心は次の収縮の目標の安置（プラグインが #znowx・#ztargetx などに書く）。円の内側に収まる範囲に絞る
scoreboard players set #7 br.tmp 7
scoreboard players set #10 br.tmp 10
data modify storage oa:br_spawn x set from storage oa:br center.x
data modify storage oa:br_spawn z set from storage oa:br center.z
data modify storage oa:br_spawn y set from storage oa:br center.y
# 1.9.160: 落下地点は「次の縮小が終わったあとのエリア」の内側（端から10ブロック内側）から選ぶ。
# 1.9.161: 予告は縮小のない時間（tick 3900・6300・8700）に移した。第1便は一辺160、第2便・第3便は一辺90の内側
# 1.9.186: まばらに落とす。範囲を広げ（第1便 ±105・第2便 ±70・第3便 ±45。今のエリアの端から10ブロック内側まで）、
# 中心から近すぎる場所（第1便 35・第2便 25・第3便 15 ブロック以内）は選び直す（br/supply/far_check）。以前は ±70・±35 で中心に寄っていた
scoreboard players set #range br.tmp 105
execute if score #time br.time matches 6300..8699 run scoreboard players set #range br.tmp 70
execute if score #time br.time matches 8700.. run scoreboard players set #range br.tmp 45
scoreboard players operation #rcap br.tmp = #half br.tmp
scoreboard players operation #rcap br.tmp /= #1000 br.tmp
scoreboard players remove #rcap br.tmp 10
scoreboard players operation #range br.tmp < #rcap br.tmp
function oa:br/zone/area {use:"target",margin:10}
execute if score #zrb br.tmp matches 1.. run scoreboard players operation #range br.tmp < #zone_range br.tmp
execute if score #range br.tmp matches ..4 run scoreboard players set #range br.tmp 5
scoreboard players set #sup_min2 br.tmp 1225
execute if score #time br.time matches 6300..8699 run scoreboard players set #sup_min2 br.tmp 625
execute if score #time br.time matches 8700.. run scoreboard players set #sup_min2 br.tmp 225
execute store result storage oa:br_spawn range int 1 run scoreboard players get #range br.tmp
execute if score #map oa.mapid matches 0 in oa:br run function oa:br/supply/place with storage oa:br_spawn
execute if score #map oa.mapid matches 1 in oa:br_nether run function oa:br/supply/place with storage oa:br_spawn
execute if score #map oa.mapid matches 2 in oa:br_cave run function oa:br/supply/place with storage oa:br_spawn
execute if score #map oa.mapid matches 3 in oa:br_sky run function oa:br/supply/place with storage oa:br_spawn
execute if score #map oa.mapid matches 4 in oa:br_end run function oa:br/supply/place with storage oa:br_spawn
