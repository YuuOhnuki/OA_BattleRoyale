execute if score #half br.tmp matches ..5000 run return 0
data modify storage oa:br_spawn x set from storage oa:br center.x
data modify storage oa:br_spawn z set from storage oa:br center.z
data modify storage oa:br_spawn y set from storage oa:br center.y
# 1.9.160: 落下地点は、予告の時点のエリアではなく「縮小が終わったあとのエリア」の内側から選ぶ。
# 第1便（tick 4800）と第2便（7200）は縮小の開始と同時に予告するので、縮む前の範囲で選ぶとエリア外に落ちやすかった。
# 第1便：一辺160（半分80）、第2便・第3便：一辺90（半分45）。端から10ブロック内側まで。
scoreboard players operation #range br.tmp = #half br.tmp
execute if score #time br.time matches 4800..5999 run scoreboard players set #range br.tmp 80000
execute if score #time br.time matches 7200..10799 run scoreboard players set #range br.tmp 45000
scoreboard players operation #range br.tmp /= #1000 br.tmp
scoreboard players remove #range br.tmp 10
execute if score #range br.tmp matches ..4 run scoreboard players set #range br.tmp 5
execute store result storage oa:br_spawn range int 1 run scoreboard players get #range br.tmp
execute if score #map oa.mapid matches 0 in oa:br run function oa:br/supply/place with storage oa:br_spawn
execute if score #map oa.mapid matches 1 in oa:br_nether run function oa:br/supply/place with storage oa:br_spawn
