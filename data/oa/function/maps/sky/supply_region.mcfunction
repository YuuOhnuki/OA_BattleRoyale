# 生成: scripts/build_map_float.py sky（直接編集しない）。空中補給の場所名（中心からの相対座標 #rx,#rz は br/supply/region で計算済み）。いちばん近い地点（今の組み合わせ）の名前
scoreboard players set #rbest br.tmp 2147483647
data modify storage oa:supply region set value "天空都市"
scoreboard players operation #rdx br.tmp = #rx br.tmp
scoreboard players remove #rdx br.tmp 0
scoreboard players operation #rdx br.tmp *= #rdx br.tmp
scoreboard players operation #rdz br.tmp = #rz br.tmp
scoreboard players remove #rdz br.tmp 0
scoreboard players operation #rdz br.tmp *= #rdz br.tmp
scoreboard players operation #rdx br.tmp += #rdz br.tmp
execute if score #rdx br.tmp < #rbest br.tmp run data modify storage oa:supply region set value "天空城のあたり"
execute if score #rdx br.tmp < #rbest br.tmp run scoreboard players operation #rbest br.tmp = #rdx br.tmp
scoreboard players operation #rdx br.tmp = #rx br.tmp
scoreboard players remove #rdx br.tmp 125
scoreboard players operation #rdx br.tmp *= #rdx br.tmp
scoreboard players operation #rdz br.tmp = #rz br.tmp
scoreboard players remove #rdz br.tmp 125
scoreboard players operation #rdz br.tmp *= #rdz br.tmp
scoreboard players operation #rdx br.tmp += #rdz br.tmp
execute if score #rdx br.tmp < #rbest br.tmp run data modify storage oa:supply region set value "北東の小島のあたり"
execute if score #rdx br.tmp < #rbest br.tmp run scoreboard players operation #rbest br.tmp = #rdx br.tmp
scoreboard players operation #rdx br.tmp = #rx br.tmp
scoreboard players add #rdx br.tmp 125
scoreboard players operation #rdx br.tmp *= #rdx br.tmp
scoreboard players operation #rdz br.tmp = #rz br.tmp
scoreboard players remove #rdz br.tmp 125
scoreboard players operation #rdz br.tmp *= #rdz br.tmp
scoreboard players operation #rdx br.tmp += #rdz br.tmp
execute if score #rdx br.tmp < #rbest br.tmp run data modify storage oa:supply region set value "北西の小島のあたり"
execute if score #rdx br.tmp < #rbest br.tmp run scoreboard players operation #rbest br.tmp = #rdx br.tmp
scoreboard players operation #rdx br.tmp = #rx br.tmp
scoreboard players add #rdx br.tmp 125
scoreboard players operation #rdx br.tmp *= #rdx br.tmp
scoreboard players operation #rdz br.tmp = #rz br.tmp
scoreboard players add #rdz br.tmp 125
scoreboard players operation #rdz br.tmp *= #rdz br.tmp
scoreboard players operation #rdx br.tmp += #rdz br.tmp
execute if score #rdx br.tmp < #rbest br.tmp run data modify storage oa:supply region set value "南西の小島のあたり"
execute if score #rdx br.tmp < #rbest br.tmp run scoreboard players operation #rbest br.tmp = #rdx br.tmp
scoreboard players operation #rdx br.tmp = #rx br.tmp
scoreboard players remove #rdx br.tmp 125
scoreboard players operation #rdx br.tmp *= #rdx br.tmp
scoreboard players operation #rdz br.tmp = #rz br.tmp
scoreboard players add #rdz br.tmp 125
scoreboard players operation #rdz br.tmp *= #rdz br.tmp
scoreboard players operation #rdx br.tmp += #rdz br.tmp
execute if score #rdx br.tmp < #rbest br.tmp run data modify storage oa:supply region set value "南東の小島のあたり"
execute if score #rdx br.tmp < #rbest br.tmp run scoreboard players operation #rbest br.tmp = #rdx br.tmp
execute if score #sv0 oa.map2 matches 0 run scoreboard players operation #rdx br.tmp = #rx br.tmp
execute if score #sv0 oa.map2 matches 0 run scoreboard players remove #rdx br.tmp 93
execute if score #sv0 oa.map2 matches 0 run scoreboard players operation #rdx br.tmp *= #rdx br.tmp
execute if score #sv0 oa.map2 matches 0 run scoreboard players operation #rdz br.tmp = #rz br.tmp
execute if score #sv0 oa.map2 matches 0 run scoreboard players add #rdz br.tmp 7
execute if score #sv0 oa.map2 matches 0 run scoreboard players operation #rdz br.tmp *= #rdz br.tmp
execute if score #sv0 oa.map2 matches 0 run scoreboard players operation #rdx br.tmp += #rdz br.tmp
execute if score #sv0 oa.map2 matches 0 if score #rdx br.tmp < #rbest br.tmp run data modify storage oa:supply region set value "崩れた岩の島のあたり"
execute if score #sv0 oa.map2 matches 0 if score #rdx br.tmp < #rbest br.tmp run scoreboard players operation #rbest br.tmp = #rdx br.tmp
execute if score #sv0 oa.map2 matches 1 run scoreboard players operation #rdx br.tmp = #rx br.tmp
execute if score #sv0 oa.map2 matches 1 run scoreboard players remove #rdx br.tmp 93
execute if score #sv0 oa.map2 matches 1 run scoreboard players operation #rdx br.tmp *= #rdx br.tmp
execute if score #sv0 oa.map2 matches 1 run scoreboard players operation #rdz br.tmp = #rz br.tmp
execute if score #sv0 oa.map2 matches 1 run scoreboard players add #rdz br.tmp 7
execute if score #sv0 oa.map2 matches 1 run scoreboard players operation #rdz br.tmp *= #rdz br.tmp
execute if score #sv0 oa.map2 matches 1 run scoreboard players operation #rdx br.tmp += #rdz br.tmp
execute if score #sv0 oa.map2 matches 1 if score #rdx br.tmp < #rbest br.tmp run data modify storage oa:supply region set value "見張り塔の島のあたり"
execute if score #sv0 oa.map2 matches 1 if score #rdx br.tmp < #rbest br.tmp run scoreboard players operation #rbest br.tmp = #rdx br.tmp
execute if score #sv0 oa.map2 matches 2 run scoreboard players operation #rdx br.tmp = #rx br.tmp
execute if score #sv0 oa.map2 matches 2 run scoreboard players remove #rdx br.tmp 93
execute if score #sv0 oa.map2 matches 2 run scoreboard players operation #rdx br.tmp *= #rdx br.tmp
execute if score #sv0 oa.map2 matches 2 run scoreboard players operation #rdz br.tmp = #rz br.tmp
execute if score #sv0 oa.map2 matches 2 run scoreboard players add #rdz br.tmp 7
execute if score #sv0 oa.map2 matches 2 run scoreboard players operation #rdz br.tmp *= #rdz br.tmp
execute if score #sv0 oa.map2 matches 2 run scoreboard players operation #rdx br.tmp += #rdz br.tmp
execute if score #sv0 oa.map2 matches 2 if score #rdx br.tmp < #rbest br.tmp run data modify storage oa:supply region set value "庭園の島のあたり"
execute if score #sv0 oa.map2 matches 2 if score #rdx br.tmp < #rbest br.tmp run scoreboard players operation #rbest br.tmp = #rdx br.tmp
execute if score #sv1 oa.map2 matches 0 run scoreboard players operation #rdx br.tmp = #rx br.tmp
execute if score #sv1 oa.map2 matches 0 run scoreboard players remove #rdx br.tmp 65
execute if score #sv1 oa.map2 matches 0 run scoreboard players operation #rdx br.tmp *= #rdx br.tmp
execute if score #sv1 oa.map2 matches 0 run scoreboard players operation #rdz br.tmp = #rz br.tmp
execute if score #sv1 oa.map2 matches 0 run scoreboard players remove #rdz br.tmp 71
execute if score #sv1 oa.map2 matches 0 run scoreboard players operation #rdz br.tmp *= #rdz br.tmp
execute if score #sv1 oa.map2 matches 0 run scoreboard players operation #rdx br.tmp += #rdz br.tmp
execute if score #sv1 oa.map2 matches 0 if score #rdx br.tmp < #rbest br.tmp run data modify storage oa:supply region set value "崩れた岩の島のあたり"
execute if score #sv1 oa.map2 matches 0 if score #rdx br.tmp < #rbest br.tmp run scoreboard players operation #rbest br.tmp = #rdx br.tmp
execute if score #sv1 oa.map2 matches 1 run scoreboard players operation #rdx br.tmp = #rx br.tmp
execute if score #sv1 oa.map2 matches 1 run scoreboard players remove #rdx br.tmp 65
execute if score #sv1 oa.map2 matches 1 run scoreboard players operation #rdx br.tmp *= #rdx br.tmp
execute if score #sv1 oa.map2 matches 1 run scoreboard players operation #rdz br.tmp = #rz br.tmp
execute if score #sv1 oa.map2 matches 1 run scoreboard players remove #rdz br.tmp 71
execute if score #sv1 oa.map2 matches 1 run scoreboard players operation #rdz br.tmp *= #rdz br.tmp
execute if score #sv1 oa.map2 matches 1 run scoreboard players operation #rdx br.tmp += #rdz br.tmp
execute if score #sv1 oa.map2 matches 1 if score #rdx br.tmp < #rbest br.tmp run data modify storage oa:supply region set value "集落の島のあたり"
execute if score #sv1 oa.map2 matches 1 if score #rdx br.tmp < #rbest br.tmp run scoreboard players operation #rbest br.tmp = #rdx br.tmp
execute if score #sv1 oa.map2 matches 2 run scoreboard players operation #rdx br.tmp = #rx br.tmp
execute if score #sv1 oa.map2 matches 2 run scoreboard players remove #rdx br.tmp 65
execute if score #sv1 oa.map2 matches 2 run scoreboard players operation #rdx br.tmp *= #rdx br.tmp
execute if score #sv1 oa.map2 matches 2 run scoreboard players operation #rdz br.tmp = #rz br.tmp
execute if score #sv1 oa.map2 matches 2 run scoreboard players remove #rdz br.tmp 71
execute if score #sv1 oa.map2 matches 2 run scoreboard players operation #rdz br.tmp *= #rdz br.tmp
execute if score #sv1 oa.map2 matches 2 run scoreboard players operation #rdx br.tmp += #rdz br.tmp
execute if score #sv1 oa.map2 matches 2 if score #rdx br.tmp < #rbest br.tmp run data modify storage oa:supply region set value "庭園の島のあたり"
execute if score #sv1 oa.map2 matches 2 if score #rdx br.tmp < #rbest br.tmp run scoreboard players operation #rbest br.tmp = #rdx br.tmp
execute if score #sv2 oa.map2 matches 0 run scoreboard players operation #rdx br.tmp = #rx br.tmp
execute if score #sv2 oa.map2 matches 0 run scoreboard players add #rdx br.tmp 6
execute if score #sv2 oa.map2 matches 0 run scoreboard players operation #rdx br.tmp *= #rdx br.tmp
execute if score #sv2 oa.map2 matches 0 run scoreboard players operation #rdz br.tmp = #rz br.tmp
execute if score #sv2 oa.map2 matches 0 run scoreboard players remove #rdz br.tmp 91
execute if score #sv2 oa.map2 matches 0 run scoreboard players operation #rdz br.tmp *= #rdz br.tmp
execute if score #sv2 oa.map2 matches 0 run scoreboard players operation #rdx br.tmp += #rdz br.tmp
execute if score #sv2 oa.map2 matches 0 if score #rdx br.tmp < #rbest br.tmp run data modify storage oa:supply region set value "庭園の島のあたり"
execute if score #sv2 oa.map2 matches 0 if score #rdx br.tmp < #rbest br.tmp run scoreboard players operation #rbest br.tmp = #rdx br.tmp
execute if score #sv2 oa.map2 matches 1 run scoreboard players operation #rdx br.tmp = #rx br.tmp
execute if score #sv2 oa.map2 matches 1 run scoreboard players add #rdx br.tmp 6
execute if score #sv2 oa.map2 matches 1 run scoreboard players operation #rdx br.tmp *= #rdx br.tmp
execute if score #sv2 oa.map2 matches 1 run scoreboard players operation #rdz br.tmp = #rz br.tmp
execute if score #sv2 oa.map2 matches 1 run scoreboard players remove #rdz br.tmp 91
execute if score #sv2 oa.map2 matches 1 run scoreboard players operation #rdz br.tmp *= #rdz br.tmp
execute if score #sv2 oa.map2 matches 1 run scoreboard players operation #rdx br.tmp += #rdz br.tmp
execute if score #sv2 oa.map2 matches 1 if score #rdx br.tmp < #rbest br.tmp run data modify storage oa:supply region set value "集落の島のあたり"
execute if score #sv2 oa.map2 matches 1 if score #rdx br.tmp < #rbest br.tmp run scoreboard players operation #rbest br.tmp = #rdx br.tmp
execute if score #sv2 oa.map2 matches 2 run scoreboard players operation #rdx br.tmp = #rx br.tmp
execute if score #sv2 oa.map2 matches 2 run scoreboard players add #rdx br.tmp 6
execute if score #sv2 oa.map2 matches 2 run scoreboard players operation #rdx br.tmp *= #rdx br.tmp
execute if score #sv2 oa.map2 matches 2 run scoreboard players operation #rdz br.tmp = #rz br.tmp
execute if score #sv2 oa.map2 matches 2 run scoreboard players remove #rdz br.tmp 91
execute if score #sv2 oa.map2 matches 2 run scoreboard players operation #rdz br.tmp *= #rdz br.tmp
execute if score #sv2 oa.map2 matches 2 run scoreboard players operation #rdx br.tmp += #rdz br.tmp
execute if score #sv2 oa.map2 matches 2 if score #rdx br.tmp < #rbest br.tmp run data modify storage oa:supply region set value "見張り塔の島のあたり"
execute if score #sv2 oa.map2 matches 2 if score #rdx br.tmp < #rbest br.tmp run scoreboard players operation #rbest br.tmp = #rdx br.tmp
execute if score #sv3 oa.map2 matches 0 run scoreboard players operation #rdx br.tmp = #rx br.tmp
execute if score #sv3 oa.map2 matches 0 run scoreboard players add #rdx br.tmp 73
execute if score #sv3 oa.map2 matches 0 run scoreboard players operation #rdx br.tmp *= #rdx br.tmp
execute if score #sv3 oa.map2 matches 0 run scoreboard players operation #rdz br.tmp = #rz br.tmp
execute if score #sv3 oa.map2 matches 0 run scoreboard players remove #rdz br.tmp 69
execute if score #sv3 oa.map2 matches 0 run scoreboard players operation #rdz br.tmp *= #rdz br.tmp
execute if score #sv3 oa.map2 matches 0 run scoreboard players operation #rdx br.tmp += #rdz br.tmp
execute if score #sv3 oa.map2 matches 0 if score #rdx br.tmp < #rbest br.tmp run data modify storage oa:supply region set value "廃墟の島のあたり"
execute if score #sv3 oa.map2 matches 0 if score #rdx br.tmp < #rbest br.tmp run scoreboard players operation #rbest br.tmp = #rdx br.tmp
execute if score #sv3 oa.map2 matches 1 run scoreboard players operation #rdx br.tmp = #rx br.tmp
execute if score #sv3 oa.map2 matches 1 run scoreboard players add #rdx br.tmp 73
execute if score #sv3 oa.map2 matches 1 run scoreboard players operation #rdx br.tmp *= #rdx br.tmp
execute if score #sv3 oa.map2 matches 1 run scoreboard players operation #rdz br.tmp = #rz br.tmp
execute if score #sv3 oa.map2 matches 1 run scoreboard players remove #rdz br.tmp 69
execute if score #sv3 oa.map2 matches 1 run scoreboard players operation #rdz br.tmp *= #rdz br.tmp
execute if score #sv3 oa.map2 matches 1 run scoreboard players operation #rdx br.tmp += #rdz br.tmp
execute if score #sv3 oa.map2 matches 1 if score #rdx br.tmp < #rbest br.tmp run data modify storage oa:supply region set value "集落の島のあたり"
execute if score #sv3 oa.map2 matches 1 if score #rdx br.tmp < #rbest br.tmp run scoreboard players operation #rbest br.tmp = #rdx br.tmp
execute if score #sv3 oa.map2 matches 2 run scoreboard players operation #rdx br.tmp = #rx br.tmp
execute if score #sv3 oa.map2 matches 2 run scoreboard players add #rdx br.tmp 73
execute if score #sv3 oa.map2 matches 2 run scoreboard players operation #rdx br.tmp *= #rdx br.tmp
execute if score #sv3 oa.map2 matches 2 run scoreboard players operation #rdz br.tmp = #rz br.tmp
execute if score #sv3 oa.map2 matches 2 run scoreboard players remove #rdz br.tmp 69
execute if score #sv3 oa.map2 matches 2 run scoreboard players operation #rdz br.tmp *= #rdz br.tmp
execute if score #sv3 oa.map2 matches 2 run scoreboard players operation #rdx br.tmp += #rdz br.tmp
execute if score #sv3 oa.map2 matches 2 if score #rdx br.tmp < #rbest br.tmp run data modify storage oa:supply region set value "見張り塔の島のあたり"
execute if score #sv3 oa.map2 matches 2 if score #rdx br.tmp < #rbest br.tmp run scoreboard players operation #rbest br.tmp = #rdx br.tmp
execute if score #sv4 oa.map2 matches 0 run scoreboard players operation #rdx br.tmp = #rx br.tmp
execute if score #sv4 oa.map2 matches 0 run scoreboard players add #rdx br.tmp 91
execute if score #sv4 oa.map2 matches 0 run scoreboard players operation #rdx br.tmp *= #rdx br.tmp
execute if score #sv4 oa.map2 matches 0 run scoreboard players operation #rdz br.tmp = #rz br.tmp
execute if score #sv4 oa.map2 matches 0 run scoreboard players add #rdz br.tmp 8
execute if score #sv4 oa.map2 matches 0 run scoreboard players operation #rdz br.tmp *= #rdz br.tmp
execute if score #sv4 oa.map2 matches 0 run scoreboard players operation #rdx br.tmp += #rdz br.tmp
execute if score #sv4 oa.map2 matches 0 if score #rdx br.tmp < #rbest br.tmp run data modify storage oa:supply region set value "廃墟の島のあたり"
execute if score #sv4 oa.map2 matches 0 if score #rdx br.tmp < #rbest br.tmp run scoreboard players operation #rbest br.tmp = #rdx br.tmp
execute if score #sv4 oa.map2 matches 1 run scoreboard players operation #rdx br.tmp = #rx br.tmp
execute if score #sv4 oa.map2 matches 1 run scoreboard players add #rdx br.tmp 91
execute if score #sv4 oa.map2 matches 1 run scoreboard players operation #rdx br.tmp *= #rdx br.tmp
execute if score #sv4 oa.map2 matches 1 run scoreboard players operation #rdz br.tmp = #rz br.tmp
execute if score #sv4 oa.map2 matches 1 run scoreboard players add #rdz br.tmp 8
execute if score #sv4 oa.map2 matches 1 run scoreboard players operation #rdz br.tmp *= #rdz br.tmp
execute if score #sv4 oa.map2 matches 1 run scoreboard players operation #rdx br.tmp += #rdz br.tmp
execute if score #sv4 oa.map2 matches 1 if score #rdx br.tmp < #rbest br.tmp run data modify storage oa:supply region set value "崩れた岩の島のあたり"
execute if score #sv4 oa.map2 matches 1 if score #rdx br.tmp < #rbest br.tmp run scoreboard players operation #rbest br.tmp = #rdx br.tmp
execute if score #sv4 oa.map2 matches 2 run scoreboard players operation #rdx br.tmp = #rx br.tmp
execute if score #sv4 oa.map2 matches 2 run scoreboard players add #rdx br.tmp 91
execute if score #sv4 oa.map2 matches 2 run scoreboard players operation #rdx br.tmp *= #rdx br.tmp
execute if score #sv4 oa.map2 matches 2 run scoreboard players operation #rdz br.tmp = #rz br.tmp
execute if score #sv4 oa.map2 matches 2 run scoreboard players add #rdz br.tmp 8
execute if score #sv4 oa.map2 matches 2 run scoreboard players operation #rdz br.tmp *= #rdz br.tmp
execute if score #sv4 oa.map2 matches 2 run scoreboard players operation #rdx br.tmp += #rdz br.tmp
execute if score #sv4 oa.map2 matches 2 if score #rdx br.tmp < #rbest br.tmp run data modify storage oa:supply region set value "神殿の島のあたり"
execute if score #sv4 oa.map2 matches 2 if score #rdx br.tmp < #rbest br.tmp run scoreboard players operation #rbest br.tmp = #rdx br.tmp
execute if score #sv5 oa.map2 matches 0 run scoreboard players operation #rdx br.tmp = #rx br.tmp
execute if score #sv5 oa.map2 matches 0 run scoreboard players add #rdx br.tmp 72
execute if score #sv5 oa.map2 matches 0 run scoreboard players operation #rdx br.tmp *= #rdx br.tmp
execute if score #sv5 oa.map2 matches 0 run scoreboard players operation #rdz br.tmp = #rz br.tmp
execute if score #sv5 oa.map2 matches 0 run scoreboard players add #rdz br.tmp 62
execute if score #sv5 oa.map2 matches 0 run scoreboard players operation #rdz br.tmp *= #rdz br.tmp
execute if score #sv5 oa.map2 matches 0 run scoreboard players operation #rdx br.tmp += #rdz br.tmp
execute if score #sv5 oa.map2 matches 0 if score #rdx br.tmp < #rbest br.tmp run data modify storage oa:supply region set value "神殿の島のあたり"
execute if score #sv5 oa.map2 matches 0 if score #rdx br.tmp < #rbest br.tmp run scoreboard players operation #rbest br.tmp = #rdx br.tmp
execute if score #sv5 oa.map2 matches 1 run scoreboard players operation #rdx br.tmp = #rx br.tmp
execute if score #sv5 oa.map2 matches 1 run scoreboard players add #rdx br.tmp 72
execute if score #sv5 oa.map2 matches 1 run scoreboard players operation #rdx br.tmp *= #rdx br.tmp
execute if score #sv5 oa.map2 matches 1 run scoreboard players operation #rdz br.tmp = #rz br.tmp
execute if score #sv5 oa.map2 matches 1 run scoreboard players add #rdz br.tmp 62
execute if score #sv5 oa.map2 matches 1 run scoreboard players operation #rdz br.tmp *= #rdz br.tmp
execute if score #sv5 oa.map2 matches 1 run scoreboard players operation #rdx br.tmp += #rdz br.tmp
execute if score #sv5 oa.map2 matches 1 if score #rdx br.tmp < #rbest br.tmp run data modify storage oa:supply region set value "見張り塔の島のあたり"
execute if score #sv5 oa.map2 matches 1 if score #rdx br.tmp < #rbest br.tmp run scoreboard players operation #rbest br.tmp = #rdx br.tmp
execute if score #sv5 oa.map2 matches 2 run scoreboard players operation #rdx br.tmp = #rx br.tmp
execute if score #sv5 oa.map2 matches 2 run scoreboard players add #rdx br.tmp 72
execute if score #sv5 oa.map2 matches 2 run scoreboard players operation #rdx br.tmp *= #rdx br.tmp
execute if score #sv5 oa.map2 matches 2 run scoreboard players operation #rdz br.tmp = #rz br.tmp
execute if score #sv5 oa.map2 matches 2 run scoreboard players add #rdz br.tmp 62
execute if score #sv5 oa.map2 matches 2 run scoreboard players operation #rdz br.tmp *= #rdz br.tmp
execute if score #sv5 oa.map2 matches 2 run scoreboard players operation #rdx br.tmp += #rdz br.tmp
execute if score #sv5 oa.map2 matches 2 if score #rdx br.tmp < #rbest br.tmp run data modify storage oa:supply region set value "集落の島のあたり"
execute if score #sv5 oa.map2 matches 2 if score #rdx br.tmp < #rbest br.tmp run scoreboard players operation #rbest br.tmp = #rdx br.tmp
execute if score #sv6 oa.map2 matches 0 run scoreboard players operation #rdx br.tmp = #rx br.tmp
execute if score #sv6 oa.map2 matches 0 run scoreboard players remove #rdx br.tmp 7
execute if score #sv6 oa.map2 matches 0 run scoreboard players operation #rdx br.tmp *= #rdx br.tmp
execute if score #sv6 oa.map2 matches 0 run scoreboard players operation #rdz br.tmp = #rz br.tmp
execute if score #sv6 oa.map2 matches 0 run scoreboard players add #rdz br.tmp 92
execute if score #sv6 oa.map2 matches 0 run scoreboard players operation #rdz br.tmp *= #rdz br.tmp
execute if score #sv6 oa.map2 matches 0 run scoreboard players operation #rdx br.tmp += #rdz br.tmp
execute if score #sv6 oa.map2 matches 0 if score #rdx br.tmp < #rbest br.tmp run data modify storage oa:supply region set value "見張り塔の島のあたり"
execute if score #sv6 oa.map2 matches 0 if score #rdx br.tmp < #rbest br.tmp run scoreboard players operation #rbest br.tmp = #rdx br.tmp
execute if score #sv6 oa.map2 matches 1 run scoreboard players operation #rdx br.tmp = #rx br.tmp
execute if score #sv6 oa.map2 matches 1 run scoreboard players remove #rdx br.tmp 7
execute if score #sv6 oa.map2 matches 1 run scoreboard players operation #rdx br.tmp *= #rdx br.tmp
execute if score #sv6 oa.map2 matches 1 run scoreboard players operation #rdz br.tmp = #rz br.tmp
execute if score #sv6 oa.map2 matches 1 run scoreboard players add #rdz br.tmp 92
execute if score #sv6 oa.map2 matches 1 run scoreboard players operation #rdz br.tmp *= #rdz br.tmp
execute if score #sv6 oa.map2 matches 1 run scoreboard players operation #rdx br.tmp += #rdz br.tmp
execute if score #sv6 oa.map2 matches 1 if score #rdx br.tmp < #rbest br.tmp run data modify storage oa:supply region set value "神殿の島のあたり"
execute if score #sv6 oa.map2 matches 1 if score #rdx br.tmp < #rbest br.tmp run scoreboard players operation #rbest br.tmp = #rdx br.tmp
execute if score #sv6 oa.map2 matches 2 run scoreboard players operation #rdx br.tmp = #rx br.tmp
execute if score #sv6 oa.map2 matches 2 run scoreboard players remove #rdx br.tmp 7
execute if score #sv6 oa.map2 matches 2 run scoreboard players operation #rdx br.tmp *= #rdx br.tmp
execute if score #sv6 oa.map2 matches 2 run scoreboard players operation #rdz br.tmp = #rz br.tmp
execute if score #sv6 oa.map2 matches 2 run scoreboard players add #rdz br.tmp 92
execute if score #sv6 oa.map2 matches 2 run scoreboard players operation #rdz br.tmp *= #rdz br.tmp
execute if score #sv6 oa.map2 matches 2 run scoreboard players operation #rdx br.tmp += #rdz br.tmp
execute if score #sv6 oa.map2 matches 2 if score #rdx br.tmp < #rbest br.tmp run data modify storage oa:supply region set value "集落の島のあたり"
execute if score #sv6 oa.map2 matches 2 if score #rdx br.tmp < #rbest br.tmp run scoreboard players operation #rbest br.tmp = #rdx br.tmp
execute if score #sv7 oa.map2 matches 0 run scoreboard players operation #rdx br.tmp = #rx br.tmp
execute if score #sv7 oa.map2 matches 0 run scoreboard players remove #rdx br.tmp 63
execute if score #sv7 oa.map2 matches 0 run scoreboard players operation #rdx br.tmp *= #rdx br.tmp
execute if score #sv7 oa.map2 matches 0 run scoreboard players operation #rdz br.tmp = #rz br.tmp
execute if score #sv7 oa.map2 matches 0 run scoreboard players add #rdz br.tmp 68
execute if score #sv7 oa.map2 matches 0 run scoreboard players operation #rdz br.tmp *= #rdz br.tmp
execute if score #sv7 oa.map2 matches 0 run scoreboard players operation #rdx br.tmp += #rdz br.tmp
execute if score #sv7 oa.map2 matches 0 if score #rdx br.tmp < #rbest br.tmp run data modify storage oa:supply region set value "庭園の島のあたり"
execute if score #sv7 oa.map2 matches 0 if score #rdx br.tmp < #rbest br.tmp run scoreboard players operation #rbest br.tmp = #rdx br.tmp
execute if score #sv7 oa.map2 matches 1 run scoreboard players operation #rdx br.tmp = #rx br.tmp
execute if score #sv7 oa.map2 matches 1 run scoreboard players remove #rdx br.tmp 63
execute if score #sv7 oa.map2 matches 1 run scoreboard players operation #rdx br.tmp *= #rdx br.tmp
execute if score #sv7 oa.map2 matches 1 run scoreboard players operation #rdz br.tmp = #rz br.tmp
execute if score #sv7 oa.map2 matches 1 run scoreboard players add #rdz br.tmp 68
execute if score #sv7 oa.map2 matches 1 run scoreboard players operation #rdz br.tmp *= #rdz br.tmp
execute if score #sv7 oa.map2 matches 1 run scoreboard players operation #rdx br.tmp += #rdz br.tmp
execute if score #sv7 oa.map2 matches 1 if score #rdx br.tmp < #rbest br.tmp run data modify storage oa:supply region set value "森林の島のあたり"
execute if score #sv7 oa.map2 matches 1 if score #rdx br.tmp < #rbest br.tmp run scoreboard players operation #rbest br.tmp = #rdx br.tmp
execute if score #sv7 oa.map2 matches 2 run scoreboard players operation #rdx br.tmp = #rx br.tmp
execute if score #sv7 oa.map2 matches 2 run scoreboard players remove #rdx br.tmp 63
execute if score #sv7 oa.map2 matches 2 run scoreboard players operation #rdx br.tmp *= #rdx br.tmp
execute if score #sv7 oa.map2 matches 2 run scoreboard players operation #rdz br.tmp = #rz br.tmp
execute if score #sv7 oa.map2 matches 2 run scoreboard players add #rdz br.tmp 68
execute if score #sv7 oa.map2 matches 2 run scoreboard players operation #rdz br.tmp *= #rdz br.tmp
execute if score #sv7 oa.map2 matches 2 run scoreboard players operation #rdx br.tmp += #rdz br.tmp
execute if score #sv7 oa.map2 matches 2 if score #rdx br.tmp < #rbest br.tmp run data modify storage oa:supply region set value "神殿の島のあたり"
execute if score #sv7 oa.map2 matches 2 if score #rdx br.tmp < #rbest br.tmp run scoreboard players operation #rbest br.tmp = #rdx br.tmp
