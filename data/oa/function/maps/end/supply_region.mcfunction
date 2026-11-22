# 生成: scripts/build_map_float.py end（直接編集しない）。空中補給の場所名（中心からの相対座標 #rx,#rz は br/supply/region で計算済み）。いちばん近い地点（今の組み合わせ）の名前
scoreboard players set #rbest br.tmp 2147483647
data modify storage oa:supply region set value "異界"
scoreboard players operation #rdx br.tmp = #rx br.tmp
scoreboard players remove #rdx br.tmp 0
scoreboard players operation #rdx br.tmp *= #rdx br.tmp
scoreboard players operation #rdz br.tmp = #rz br.tmp
scoreboard players remove #rdz br.tmp 0
scoreboard players operation #rdz br.tmp *= #rdz br.tmp
scoreboard players operation #rdx br.tmp += #rdz br.tmp
execute if score #rdx br.tmp < #rbest br.tmp run data modify storage oa:supply region set value "異界神殿のあたり"
execute if score #rdx br.tmp < #rbest br.tmp run scoreboard players operation #rbest br.tmp = #rdx br.tmp
scoreboard players operation #rdx br.tmp = #rx br.tmp
scoreboard players remove #rdx br.tmp 125
scoreboard players operation #rdx br.tmp *= #rdx br.tmp
scoreboard players operation #rdz br.tmp = #rz br.tmp
scoreboard players remove #rdz br.tmp 125
scoreboard players operation #rdz br.tmp *= #rdz br.tmp
scoreboard players operation #rdx br.tmp += #rdz br.tmp
execute if score #rdx br.tmp < #rbest br.tmp run data modify storage oa:supply region set value "北東の浮岩のあたり"
execute if score #rdx br.tmp < #rbest br.tmp run scoreboard players operation #rbest br.tmp = #rdx br.tmp
scoreboard players operation #rdx br.tmp = #rx br.tmp
scoreboard players add #rdx br.tmp 125
scoreboard players operation #rdx br.tmp *= #rdx br.tmp
scoreboard players operation #rdz br.tmp = #rz br.tmp
scoreboard players remove #rdz br.tmp 125
scoreboard players operation #rdz br.tmp *= #rdz br.tmp
scoreboard players operation #rdx br.tmp += #rdz br.tmp
execute if score #rdx br.tmp < #rbest br.tmp run data modify storage oa:supply region set value "北西の浮岩のあたり"
execute if score #rdx br.tmp < #rbest br.tmp run scoreboard players operation #rbest br.tmp = #rdx br.tmp
scoreboard players operation #rdx br.tmp = #rx br.tmp
scoreboard players add #rdx br.tmp 125
scoreboard players operation #rdx br.tmp *= #rdx br.tmp
scoreboard players operation #rdz br.tmp = #rz br.tmp
scoreboard players add #rdz br.tmp 125
scoreboard players operation #rdz br.tmp *= #rdz br.tmp
scoreboard players operation #rdx br.tmp += #rdz br.tmp
execute if score #rdx br.tmp < #rbest br.tmp run data modify storage oa:supply region set value "南西の浮岩のあたり"
execute if score #rdx br.tmp < #rbest br.tmp run scoreboard players operation #rbest br.tmp = #rdx br.tmp
scoreboard players operation #rdx br.tmp = #rx br.tmp
scoreboard players remove #rdx br.tmp 125
scoreboard players operation #rdx br.tmp *= #rdx br.tmp
scoreboard players operation #rdz br.tmp = #rz br.tmp
scoreboard players add #rdz br.tmp 125
scoreboard players operation #rdz br.tmp *= #rdz br.tmp
scoreboard players operation #rdx br.tmp += #rdz br.tmp
execute if score #rdx br.tmp < #rbest br.tmp run data modify storage oa:supply region set value "南東の浮岩のあたり"
execute if score #rdx br.tmp < #rbest br.tmp run scoreboard players operation #rbest br.tmp = #rdx br.tmp
execute if score #sv0 oa.map2 matches 0 run scoreboard players operation #rdx br.tmp = #rx br.tmp
execute if score #sv0 oa.map2 matches 0 run scoreboard players remove #rdx br.tmp 100
execute if score #sv0 oa.map2 matches 0 run scoreboard players operation #rdx br.tmp *= #rdx br.tmp
execute if score #sv0 oa.map2 matches 0 run scoreboard players operation #rdz br.tmp = #rz br.tmp
execute if score #sv0 oa.map2 matches 0 run scoreboard players remove #rdz br.tmp 8
execute if score #sv0 oa.map2 matches 0 run scoreboard players operation #rdz br.tmp *= #rdz br.tmp
execute if score #sv0 oa.map2 matches 0 run scoreboard players operation #rdx br.tmp += #rdz br.tmp
execute if score #sv0 oa.map2 matches 0 if score #rdx br.tmp < #rbest br.tmp run data modify storage oa:supply region set value "黒曜石の森のあたり"
execute if score #sv0 oa.map2 matches 0 if score #rdx br.tmp < #rbest br.tmp run scoreboard players operation #rbest br.tmp = #rdx br.tmp
execute if score #sv0 oa.map2 matches 1 run scoreboard players operation #rdx br.tmp = #rx br.tmp
execute if score #sv0 oa.map2 matches 1 run scoreboard players remove #rdx br.tmp 100
execute if score #sv0 oa.map2 matches 1 run scoreboard players operation #rdx br.tmp *= #rdx br.tmp
execute if score #sv0 oa.map2 matches 1 run scoreboard players operation #rdz br.tmp = #rz br.tmp
execute if score #sv0 oa.map2 matches 1 run scoreboard players remove #rdz br.tmp 8
execute if score #sv0 oa.map2 matches 1 run scoreboard players operation #rdz br.tmp *= #rdz br.tmp
execute if score #sv0 oa.map2 matches 1 run scoreboard players operation #rdx br.tmp += #rdz br.tmp
execute if score #sv0 oa.map2 matches 1 if score #rdx br.tmp < #rbest br.tmp run data modify storage oa:supply region set value "廃墟の島のあたり"
execute if score #sv0 oa.map2 matches 1 if score #rdx br.tmp < #rbest br.tmp run scoreboard players operation #rbest br.tmp = #rdx br.tmp
execute if score #sv0 oa.map2 matches 2 run scoreboard players operation #rdx br.tmp = #rx br.tmp
execute if score #sv0 oa.map2 matches 2 run scoreboard players remove #rdx br.tmp 100
execute if score #sv0 oa.map2 matches 2 run scoreboard players operation #rdx br.tmp *= #rdx br.tmp
execute if score #sv0 oa.map2 matches 2 run scoreboard players operation #rdz br.tmp = #rz br.tmp
execute if score #sv0 oa.map2 matches 2 run scoreboard players remove #rdz br.tmp 8
execute if score #sv0 oa.map2 matches 2 run scoreboard players operation #rdz br.tmp *= #rdz br.tmp
execute if score #sv0 oa.map2 matches 2 run scoreboard players operation #rdx br.tmp += #rdz br.tmp
execute if score #sv0 oa.map2 matches 2 if score #rdx br.tmp < #rbest br.tmp run data modify storage oa:supply region set value "紫の草の島のあたり"
execute if score #sv0 oa.map2 matches 2 if score #rdx br.tmp < #rbest br.tmp run scoreboard players operation #rbest br.tmp = #rdx br.tmp
execute if score #sv1 oa.map2 matches 0 run scoreboard players operation #rdx br.tmp = #rx br.tmp
execute if score #sv1 oa.map2 matches 0 run scoreboard players remove #rdx br.tmp 69
execute if score #sv1 oa.map2 matches 0 run scoreboard players operation #rdx br.tmp *= #rdx br.tmp
execute if score #sv1 oa.map2 matches 0 run scoreboard players operation #rdz br.tmp = #rz br.tmp
execute if score #sv1 oa.map2 matches 0 run scoreboard players remove #rdz br.tmp 71
execute if score #sv1 oa.map2 matches 0 run scoreboard players operation #rdz br.tmp *= #rdz br.tmp
execute if score #sv1 oa.map2 matches 0 run scoreboard players operation #rdx br.tmp += #rdz br.tmp
execute if score #sv1 oa.map2 matches 0 if score #rdx br.tmp < #rbest br.tmp run data modify storage oa:supply region set value "黒曜石の森のあたり"
execute if score #sv1 oa.map2 matches 0 if score #rdx br.tmp < #rbest br.tmp run scoreboard players operation #rbest br.tmp = #rdx br.tmp
execute if score #sv1 oa.map2 matches 1 run scoreboard players operation #rdx br.tmp = #rx br.tmp
execute if score #sv1 oa.map2 matches 1 run scoreboard players remove #rdx br.tmp 69
execute if score #sv1 oa.map2 matches 1 run scoreboard players operation #rdx br.tmp *= #rdx br.tmp
execute if score #sv1 oa.map2 matches 1 run scoreboard players operation #rdz br.tmp = #rz br.tmp
execute if score #sv1 oa.map2 matches 1 run scoreboard players remove #rdz br.tmp 71
execute if score #sv1 oa.map2 matches 1 run scoreboard players operation #rdz br.tmp *= #rdz br.tmp
execute if score #sv1 oa.map2 matches 1 run scoreboard players operation #rdx br.tmp += #rdz br.tmp
execute if score #sv1 oa.map2 matches 1 if score #rdx br.tmp < #rbest br.tmp run data modify storage oa:supply region set value "エンドストーンの荒野のあたり"
execute if score #sv1 oa.map2 matches 1 if score #rdx br.tmp < #rbest br.tmp run scoreboard players operation #rbest br.tmp = #rdx br.tmp
execute if score #sv1 oa.map2 matches 2 run scoreboard players operation #rdx br.tmp = #rx br.tmp
execute if score #sv1 oa.map2 matches 2 run scoreboard players remove #rdx br.tmp 69
execute if score #sv1 oa.map2 matches 2 run scoreboard players operation #rdx br.tmp *= #rdx br.tmp
execute if score #sv1 oa.map2 matches 2 run scoreboard players operation #rdz br.tmp = #rz br.tmp
execute if score #sv1 oa.map2 matches 2 run scoreboard players remove #rdz br.tmp 71
execute if score #sv1 oa.map2 matches 2 run scoreboard players operation #rdz br.tmp *= #rdz br.tmp
execute if score #sv1 oa.map2 matches 2 run scoreboard players operation #rdx br.tmp += #rdz br.tmp
execute if score #sv1 oa.map2 matches 2 if score #rdx br.tmp < #rbest br.tmp run data modify storage oa:supply region set value "結晶の洞窟のあたり"
execute if score #sv1 oa.map2 matches 2 if score #rdx br.tmp < #rbest br.tmp run scoreboard players operation #rbest br.tmp = #rdx br.tmp
execute if score #sv2 oa.map2 matches 0 run scoreboard players operation #rdx br.tmp = #rx br.tmp
execute if score #sv2 oa.map2 matches 0 run scoreboard players add #rdx br.tmp 4
execute if score #sv2 oa.map2 matches 0 run scoreboard players operation #rdx br.tmp *= #rdx br.tmp
execute if score #sv2 oa.map2 matches 0 run scoreboard players operation #rdz br.tmp = #rz br.tmp
execute if score #sv2 oa.map2 matches 0 run scoreboard players remove #rdz br.tmp 98
execute if score #sv2 oa.map2 matches 0 run scoreboard players operation #rdz br.tmp *= #rdz br.tmp
execute if score #sv2 oa.map2 matches 0 run scoreboard players operation #rdx br.tmp += #rdz br.tmp
execute if score #sv2 oa.map2 matches 0 if score #rdx br.tmp < #rbest br.tmp run data modify storage oa:supply region set value "廃墟の島のあたり"
execute if score #sv2 oa.map2 matches 0 if score #rdx br.tmp < #rbest br.tmp run scoreboard players operation #rbest br.tmp = #rdx br.tmp
execute if score #sv2 oa.map2 matches 1 run scoreboard players operation #rdx br.tmp = #rx br.tmp
execute if score #sv2 oa.map2 matches 1 run scoreboard players add #rdx br.tmp 4
execute if score #sv2 oa.map2 matches 1 run scoreboard players operation #rdx br.tmp *= #rdx br.tmp
execute if score #sv2 oa.map2 matches 1 run scoreboard players operation #rdz br.tmp = #rz br.tmp
execute if score #sv2 oa.map2 matches 1 run scoreboard players remove #rdz br.tmp 98
execute if score #sv2 oa.map2 matches 1 run scoreboard players operation #rdz br.tmp *= #rdz br.tmp
execute if score #sv2 oa.map2 matches 1 run scoreboard players operation #rdx br.tmp += #rdz br.tmp
execute if score #sv2 oa.map2 matches 1 if score #rdx br.tmp < #rbest br.tmp run data modify storage oa:supply region set value "紫の草の島のあたり"
execute if score #sv2 oa.map2 matches 1 if score #rdx br.tmp < #rbest br.tmp run scoreboard players operation #rbest br.tmp = #rdx br.tmp
execute if score #sv2 oa.map2 matches 2 run scoreboard players operation #rdx br.tmp = #rx br.tmp
execute if score #sv2 oa.map2 matches 2 run scoreboard players add #rdx br.tmp 4
execute if score #sv2 oa.map2 matches 2 run scoreboard players operation #rdx br.tmp *= #rdx br.tmp
execute if score #sv2 oa.map2 matches 2 run scoreboard players operation #rdz br.tmp = #rz br.tmp
execute if score #sv2 oa.map2 matches 2 run scoreboard players remove #rdz br.tmp 98
execute if score #sv2 oa.map2 matches 2 run scoreboard players operation #rdz br.tmp *= #rdz br.tmp
execute if score #sv2 oa.map2 matches 2 run scoreboard players operation #rdx br.tmp += #rdz br.tmp
execute if score #sv2 oa.map2 matches 2 if score #rdx br.tmp < #rbest br.tmp run data modify storage oa:supply region set value "エンドストーンの荒野のあたり"
execute if score #sv2 oa.map2 matches 2 if score #rdx br.tmp < #rbest br.tmp run scoreboard players operation #rbest br.tmp = #rdx br.tmp
execute if score #sv3 oa.map2 matches 0 run scoreboard players operation #rdx br.tmp = #rx br.tmp
execute if score #sv3 oa.map2 matches 0 run scoreboard players add #rdx br.tmp 64
execute if score #sv3 oa.map2 matches 0 run scoreboard players operation #rdx br.tmp *= #rdx br.tmp
execute if score #sv3 oa.map2 matches 0 run scoreboard players operation #rdz br.tmp = #rz br.tmp
execute if score #sv3 oa.map2 matches 0 run scoreboard players remove #rdz br.tmp 76
execute if score #sv3 oa.map2 matches 0 run scoreboard players operation #rdz br.tmp *= #rdz br.tmp
execute if score #sv3 oa.map2 matches 0 run scoreboard players operation #rdx br.tmp += #rdz br.tmp
execute if score #sv3 oa.map2 matches 0 if score #rdx br.tmp < #rbest br.tmp run data modify storage oa:supply region set value "紫の草の島のあたり"
execute if score #sv3 oa.map2 matches 0 if score #rdx br.tmp < #rbest br.tmp run scoreboard players operation #rbest br.tmp = #rdx br.tmp
execute if score #sv3 oa.map2 matches 1 run scoreboard players operation #rdx br.tmp = #rx br.tmp
execute if score #sv3 oa.map2 matches 1 run scoreboard players add #rdx br.tmp 64
execute if score #sv3 oa.map2 matches 1 run scoreboard players operation #rdx br.tmp *= #rdx br.tmp
execute if score #sv3 oa.map2 matches 1 run scoreboard players operation #rdz br.tmp = #rz br.tmp
execute if score #sv3 oa.map2 matches 1 run scoreboard players remove #rdz br.tmp 76
execute if score #sv3 oa.map2 matches 1 run scoreboard players operation #rdz br.tmp *= #rdz br.tmp
execute if score #sv3 oa.map2 matches 1 run scoreboard players operation #rdx br.tmp += #rdz br.tmp
execute if score #sv3 oa.map2 matches 1 if score #rdx br.tmp < #rbest br.tmp run data modify storage oa:supply region set value "廃墟の島のあたり"
execute if score #sv3 oa.map2 matches 1 if score #rdx br.tmp < #rbest br.tmp run scoreboard players operation #rbest br.tmp = #rdx br.tmp
execute if score #sv3 oa.map2 matches 2 run scoreboard players operation #rdx br.tmp = #rx br.tmp
execute if score #sv3 oa.map2 matches 2 run scoreboard players add #rdx br.tmp 64
execute if score #sv3 oa.map2 matches 2 run scoreboard players operation #rdx br.tmp *= #rdx br.tmp
execute if score #sv3 oa.map2 matches 2 run scoreboard players operation #rdz br.tmp = #rz br.tmp
execute if score #sv3 oa.map2 matches 2 run scoreboard players remove #rdz br.tmp 76
execute if score #sv3 oa.map2 matches 2 run scoreboard players operation #rdz br.tmp *= #rdz br.tmp
execute if score #sv3 oa.map2 matches 2 run scoreboard players operation #rdx br.tmp += #rdz br.tmp
execute if score #sv3 oa.map2 matches 2 if score #rdx br.tmp < #rbest br.tmp run data modify storage oa:supply region set value "崩れたエンドシティのあたり"
execute if score #sv3 oa.map2 matches 2 if score #rdx br.tmp < #rbest br.tmp run scoreboard players operation #rbest br.tmp = #rdx br.tmp
execute if score #sv4 oa.map2 matches 0 run scoreboard players operation #rdx br.tmp = #rx br.tmp
execute if score #sv4 oa.map2 matches 0 run scoreboard players add #rdx br.tmp 92
execute if score #sv4 oa.map2 matches 0 run scoreboard players operation #rdx br.tmp *= #rdx br.tmp
execute if score #sv4 oa.map2 matches 0 run scoreboard players operation #rdz br.tmp = #rz br.tmp
execute if score #sv4 oa.map2 matches 0 run scoreboard players add #rdz br.tmp 5
execute if score #sv4 oa.map2 matches 0 run scoreboard players operation #rdz br.tmp *= #rdz br.tmp
execute if score #sv4 oa.map2 matches 0 run scoreboard players operation #rdx br.tmp += #rdz br.tmp
execute if score #sv4 oa.map2 matches 0 if score #rdx br.tmp < #rbest br.tmp run data modify storage oa:supply region set value "紫の草の島のあたり"
execute if score #sv4 oa.map2 matches 0 if score #rdx br.tmp < #rbest br.tmp run scoreboard players operation #rbest br.tmp = #rdx br.tmp
execute if score #sv4 oa.map2 matches 1 run scoreboard players operation #rdx br.tmp = #rx br.tmp
execute if score #sv4 oa.map2 matches 1 run scoreboard players add #rdx br.tmp 92
execute if score #sv4 oa.map2 matches 1 run scoreboard players operation #rdx br.tmp *= #rdx br.tmp
execute if score #sv4 oa.map2 matches 1 run scoreboard players operation #rdz br.tmp = #rz br.tmp
execute if score #sv4 oa.map2 matches 1 run scoreboard players add #rdz br.tmp 5
execute if score #sv4 oa.map2 matches 1 run scoreboard players operation #rdz br.tmp *= #rdz br.tmp
execute if score #sv4 oa.map2 matches 1 run scoreboard players operation #rdx br.tmp += #rdz br.tmp
execute if score #sv4 oa.map2 matches 1 if score #rdx br.tmp < #rbest br.tmp run data modify storage oa:supply region set value "結晶の洞窟のあたり"
execute if score #sv4 oa.map2 matches 1 if score #rdx br.tmp < #rbest br.tmp run scoreboard players operation #rbest br.tmp = #rdx br.tmp
execute if score #sv4 oa.map2 matches 2 run scoreboard players operation #rdx br.tmp = #rx br.tmp
execute if score #sv4 oa.map2 matches 2 run scoreboard players add #rdx br.tmp 92
execute if score #sv4 oa.map2 matches 2 run scoreboard players operation #rdx br.tmp *= #rdx br.tmp
execute if score #sv4 oa.map2 matches 2 run scoreboard players operation #rdz br.tmp = #rz br.tmp
execute if score #sv4 oa.map2 matches 2 run scoreboard players add #rdz br.tmp 5
execute if score #sv4 oa.map2 matches 2 run scoreboard players operation #rdz br.tmp *= #rdz br.tmp
execute if score #sv4 oa.map2 matches 2 run scoreboard players operation #rdx br.tmp += #rdz br.tmp
execute if score #sv4 oa.map2 matches 2 if score #rdx br.tmp < #rbest br.tmp run data modify storage oa:supply region set value "廃墟の島のあたり"
execute if score #sv4 oa.map2 matches 2 if score #rdx br.tmp < #rbest br.tmp run scoreboard players operation #rbest br.tmp = #rdx br.tmp
execute if score #sv5 oa.map2 matches 0 run scoreboard players operation #rdx br.tmp = #rx br.tmp
execute if score #sv5 oa.map2 matches 0 run scoreboard players add #rdx br.tmp 66
execute if score #sv5 oa.map2 matches 0 run scoreboard players operation #rdx br.tmp *= #rdx br.tmp
execute if score #sv5 oa.map2 matches 0 run scoreboard players operation #rdz br.tmp = #rz br.tmp
execute if score #sv5 oa.map2 matches 0 run scoreboard players add #rdz br.tmp 65
execute if score #sv5 oa.map2 matches 0 run scoreboard players operation #rdz br.tmp *= #rdz br.tmp
execute if score #sv5 oa.map2 matches 0 run scoreboard players operation #rdx br.tmp += #rdz br.tmp
execute if score #sv5 oa.map2 matches 0 if score #rdx br.tmp < #rbest br.tmp run data modify storage oa:supply region set value "エンドストーンの荒野のあたり"
execute if score #sv5 oa.map2 matches 0 if score #rdx br.tmp < #rbest br.tmp run scoreboard players operation #rbest br.tmp = #rdx br.tmp
execute if score #sv5 oa.map2 matches 1 run scoreboard players operation #rdx br.tmp = #rx br.tmp
execute if score #sv5 oa.map2 matches 1 run scoreboard players add #rdx br.tmp 66
execute if score #sv5 oa.map2 matches 1 run scoreboard players operation #rdx br.tmp *= #rdx br.tmp
execute if score #sv5 oa.map2 matches 1 run scoreboard players operation #rdz br.tmp = #rz br.tmp
execute if score #sv5 oa.map2 matches 1 run scoreboard players add #rdz br.tmp 65
execute if score #sv5 oa.map2 matches 1 run scoreboard players operation #rdz br.tmp *= #rdz br.tmp
execute if score #sv5 oa.map2 matches 1 run scoreboard players operation #rdx br.tmp += #rdz br.tmp
execute if score #sv5 oa.map2 matches 1 if score #rdx br.tmp < #rbest br.tmp run data modify storage oa:supply region set value "異界の塔のあたり"
execute if score #sv5 oa.map2 matches 1 if score #rdx br.tmp < #rbest br.tmp run scoreboard players operation #rbest br.tmp = #rdx br.tmp
execute if score #sv5 oa.map2 matches 2 run scoreboard players operation #rdx br.tmp = #rx br.tmp
execute if score #sv5 oa.map2 matches 2 run scoreboard players add #rdx br.tmp 66
execute if score #sv5 oa.map2 matches 2 run scoreboard players operation #rdx br.tmp *= #rdx br.tmp
execute if score #sv5 oa.map2 matches 2 run scoreboard players operation #rdz br.tmp = #rz br.tmp
execute if score #sv5 oa.map2 matches 2 run scoreboard players add #rdz br.tmp 65
execute if score #sv5 oa.map2 matches 2 run scoreboard players operation #rdz br.tmp *= #rdz br.tmp
execute if score #sv5 oa.map2 matches 2 run scoreboard players operation #rdx br.tmp += #rdz br.tmp
execute if score #sv5 oa.map2 matches 2 if score #rdx br.tmp < #rbest br.tmp run data modify storage oa:supply region set value "廃墟の島のあたり"
execute if score #sv5 oa.map2 matches 2 if score #rdx br.tmp < #rbest br.tmp run scoreboard players operation #rbest br.tmp = #rdx br.tmp
execute if score #sv6 oa.map2 matches 0 run scoreboard players operation #rdx br.tmp = #rx br.tmp
execute if score #sv6 oa.map2 matches 0 run scoreboard players remove #rdx br.tmp 2
execute if score #sv6 oa.map2 matches 0 run scoreboard players operation #rdx br.tmp *= #rdx br.tmp
execute if score #sv6 oa.map2 matches 0 run scoreboard players operation #rdz br.tmp = #rz br.tmp
execute if score #sv6 oa.map2 matches 0 run scoreboard players add #rdz br.tmp 93
execute if score #sv6 oa.map2 matches 0 run scoreboard players operation #rdz br.tmp *= #rdz br.tmp
execute if score #sv6 oa.map2 matches 0 run scoreboard players operation #rdx br.tmp += #rdz br.tmp
execute if score #sv6 oa.map2 matches 0 if score #rdx br.tmp < #rbest br.tmp run data modify storage oa:supply region set value "廃墟の島のあたり"
execute if score #sv6 oa.map2 matches 0 if score #rdx br.tmp < #rbest br.tmp run scoreboard players operation #rbest br.tmp = #rdx br.tmp
execute if score #sv6 oa.map2 matches 1 run scoreboard players operation #rdx br.tmp = #rx br.tmp
execute if score #sv6 oa.map2 matches 1 run scoreboard players remove #rdx br.tmp 2
execute if score #sv6 oa.map2 matches 1 run scoreboard players operation #rdx br.tmp *= #rdx br.tmp
execute if score #sv6 oa.map2 matches 1 run scoreboard players operation #rdz br.tmp = #rz br.tmp
execute if score #sv6 oa.map2 matches 1 run scoreboard players add #rdz br.tmp 93
execute if score #sv6 oa.map2 matches 1 run scoreboard players operation #rdz br.tmp *= #rdz br.tmp
execute if score #sv6 oa.map2 matches 1 run scoreboard players operation #rdx br.tmp += #rdz br.tmp
execute if score #sv6 oa.map2 matches 1 if score #rdx br.tmp < #rbest br.tmp run data modify storage oa:supply region set value "紫の草の島のあたり"
execute if score #sv6 oa.map2 matches 1 if score #rdx br.tmp < #rbest br.tmp run scoreboard players operation #rbest br.tmp = #rdx br.tmp
execute if score #sv6 oa.map2 matches 2 run scoreboard players operation #rdx br.tmp = #rx br.tmp
execute if score #sv6 oa.map2 matches 2 run scoreboard players remove #rdx br.tmp 2
execute if score #sv6 oa.map2 matches 2 run scoreboard players operation #rdx br.tmp *= #rdx br.tmp
execute if score #sv6 oa.map2 matches 2 run scoreboard players operation #rdz br.tmp = #rz br.tmp
execute if score #sv6 oa.map2 matches 2 run scoreboard players add #rdz br.tmp 93
execute if score #sv6 oa.map2 matches 2 run scoreboard players operation #rdz br.tmp *= #rdz br.tmp
execute if score #sv6 oa.map2 matches 2 run scoreboard players operation #rdx br.tmp += #rdz br.tmp
execute if score #sv6 oa.map2 matches 2 if score #rdx br.tmp < #rbest br.tmp run data modify storage oa:supply region set value "異界の塔のあたり"
execute if score #sv6 oa.map2 matches 2 if score #rdx br.tmp < #rbest br.tmp run scoreboard players operation #rbest br.tmp = #rdx br.tmp
execute if score #sv7 oa.map2 matches 0 run scoreboard players operation #rdx br.tmp = #rx br.tmp
execute if score #sv7 oa.map2 matches 0 run scoreboard players remove #rdx br.tmp 68
execute if score #sv7 oa.map2 matches 0 run scoreboard players operation #rdx br.tmp *= #rdx br.tmp
execute if score #sv7 oa.map2 matches 0 run scoreboard players operation #rdz br.tmp = #rz br.tmp
execute if score #sv7 oa.map2 matches 0 run scoreboard players add #rdz br.tmp 63
execute if score #sv7 oa.map2 matches 0 run scoreboard players operation #rdz br.tmp *= #rdz br.tmp
execute if score #sv7 oa.map2 matches 0 run scoreboard players operation #rdx br.tmp += #rdz br.tmp
execute if score #sv7 oa.map2 matches 0 if score #rdx br.tmp < #rbest br.tmp run data modify storage oa:supply region set value "エンドストーンの荒野のあたり"
execute if score #sv7 oa.map2 matches 0 if score #rdx br.tmp < #rbest br.tmp run scoreboard players operation #rbest br.tmp = #rdx br.tmp
execute if score #sv7 oa.map2 matches 1 run scoreboard players operation #rdx br.tmp = #rx br.tmp
execute if score #sv7 oa.map2 matches 1 run scoreboard players remove #rdx br.tmp 68
execute if score #sv7 oa.map2 matches 1 run scoreboard players operation #rdx br.tmp *= #rdx br.tmp
execute if score #sv7 oa.map2 matches 1 run scoreboard players operation #rdz br.tmp = #rz br.tmp
execute if score #sv7 oa.map2 matches 1 run scoreboard players add #rdz br.tmp 63
execute if score #sv7 oa.map2 matches 1 run scoreboard players operation #rdz br.tmp *= #rdz br.tmp
execute if score #sv7 oa.map2 matches 1 run scoreboard players operation #rdx br.tmp += #rdz br.tmp
execute if score #sv7 oa.map2 matches 1 if score #rdx br.tmp < #rbest br.tmp run data modify storage oa:supply region set value "黒曜石の森のあたり"
execute if score #sv7 oa.map2 matches 1 if score #rdx br.tmp < #rbest br.tmp run scoreboard players operation #rbest br.tmp = #rdx br.tmp
execute if score #sv7 oa.map2 matches 2 run scoreboard players operation #rdx br.tmp = #rx br.tmp
execute if score #sv7 oa.map2 matches 2 run scoreboard players remove #rdx br.tmp 68
execute if score #sv7 oa.map2 matches 2 run scoreboard players operation #rdx br.tmp *= #rdx br.tmp
execute if score #sv7 oa.map2 matches 2 run scoreboard players operation #rdz br.tmp = #rz br.tmp
execute if score #sv7 oa.map2 matches 2 run scoreboard players add #rdz br.tmp 63
execute if score #sv7 oa.map2 matches 2 run scoreboard players operation #rdz br.tmp *= #rdz br.tmp
execute if score #sv7 oa.map2 matches 2 run scoreboard players operation #rdx br.tmp += #rdz br.tmp
execute if score #sv7 oa.map2 matches 2 if score #rdx br.tmp < #rbest br.tmp run data modify storage oa:supply region set value "崩れたエンドシティのあたり"
execute if score #sv7 oa.map2 matches 2 if score #rdx br.tmp < #rbest br.tmp run scoreboard players operation #rbest br.tmp = #rdx br.tmp
