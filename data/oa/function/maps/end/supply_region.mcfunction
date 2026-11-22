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
execute if score #rdx br.tmp < #rbest br.tmp run data modify storage oa:supply region set value "竜の祭壇のあたり"
execute if score #rdx br.tmp < #rbest br.tmp run scoreboard players operation #rbest br.tmp = #rdx br.tmp
scoreboard players operation #rdx br.tmp = #rx br.tmp
scoreboard players remove #rdx br.tmp 104
scoreboard players operation #rdx br.tmp *= #rdx br.tmp
scoreboard players operation #rdz br.tmp = #rz br.tmp
scoreboard players remove #rdz br.tmp 104
scoreboard players operation #rdz br.tmp *= #rdz br.tmp
scoreboard players operation #rdx br.tmp += #rdz br.tmp
execute if score #rdx br.tmp < #rbest br.tmp run data modify storage oa:supply region set value "南東の浮岩のあたり"
execute if score #rdx br.tmp < #rbest br.tmp run scoreboard players operation #rbest br.tmp = #rdx br.tmp
scoreboard players operation #rdx br.tmp = #rx br.tmp
scoreboard players add #rdx br.tmp 104
scoreboard players operation #rdx br.tmp *= #rdx br.tmp
scoreboard players operation #rdz br.tmp = #rz br.tmp
scoreboard players remove #rdz br.tmp 104
scoreboard players operation #rdz br.tmp *= #rdz br.tmp
scoreboard players operation #rdx br.tmp += #rdz br.tmp
execute if score #rdx br.tmp < #rbest br.tmp run data modify storage oa:supply region set value "南西の浮岩のあたり"
execute if score #rdx br.tmp < #rbest br.tmp run scoreboard players operation #rbest br.tmp = #rdx br.tmp
scoreboard players operation #rdx br.tmp = #rx br.tmp
scoreboard players add #rdx br.tmp 104
scoreboard players operation #rdx br.tmp *= #rdx br.tmp
scoreboard players operation #rdz br.tmp = #rz br.tmp
scoreboard players add #rdz br.tmp 104
scoreboard players operation #rdz br.tmp *= #rdz br.tmp
scoreboard players operation #rdx br.tmp += #rdz br.tmp
execute if score #rdx br.tmp < #rbest br.tmp run data modify storage oa:supply region set value "北西の浮岩のあたり"
execute if score #rdx br.tmp < #rbest br.tmp run scoreboard players operation #rbest br.tmp = #rdx br.tmp
scoreboard players operation #rdx br.tmp = #rx br.tmp
scoreboard players remove #rdx br.tmp 104
scoreboard players operation #rdx br.tmp *= #rdx br.tmp
scoreboard players operation #rdz br.tmp = #rz br.tmp
scoreboard players add #rdz br.tmp 104
scoreboard players operation #rdz br.tmp *= #rdz br.tmp
scoreboard players operation #rdx br.tmp += #rdz br.tmp
execute if score #rdx br.tmp < #rbest br.tmp run data modify storage oa:supply region set value "北東の浮岩のあたり"
execute if score #rdx br.tmp < #rbest br.tmp run scoreboard players operation #rbest br.tmp = #rdx br.tmp
execute if score #sv0 oa.map2 matches 0 run scoreboard players operation #rdx br.tmp = #rx br.tmp
execute if score #sv0 oa.map2 matches 0 run scoreboard players remove #rdx br.tmp 84
execute if score #sv0 oa.map2 matches 0 run scoreboard players operation #rdx br.tmp *= #rdx br.tmp
execute if score #sv0 oa.map2 matches 0 run scoreboard players operation #rdz br.tmp = #rz br.tmp
execute if score #sv0 oa.map2 matches 0 run scoreboard players remove #rdz br.tmp 7
execute if score #sv0 oa.map2 matches 0 run scoreboard players operation #rdz br.tmp *= #rdz br.tmp
execute if score #sv0 oa.map2 matches 0 run scoreboard players operation #rdx br.tmp += #rdz br.tmp
execute if score #sv0 oa.map2 matches 0 if score #rdx br.tmp < #rbest br.tmp run data modify storage oa:supply region set value "異界の塔街のあたり"
execute if score #sv0 oa.map2 matches 0 if score #rdx br.tmp < #rbest br.tmp run scoreboard players operation #rbest br.tmp = #rdx br.tmp
execute if score #sv1 oa.map2 matches 0 run scoreboard players operation #rdx br.tmp = #rx br.tmp
execute if score #sv1 oa.map2 matches 0 run scoreboard players remove #rdx br.tmp 58
execute if score #sv1 oa.map2 matches 0 run scoreboard players operation #rdx br.tmp *= #rdx br.tmp
execute if score #sv1 oa.map2 matches 0 run scoreboard players operation #rdz br.tmp = #rz br.tmp
execute if score #sv1 oa.map2 matches 0 run scoreboard players remove #rdz br.tmp 59
execute if score #sv1 oa.map2 matches 0 run scoreboard players operation #rdz br.tmp *= #rdz br.tmp
execute if score #sv1 oa.map2 matches 0 run scoreboard players operation #rdx br.tmp += #rdz br.tmp
execute if score #sv1 oa.map2 matches 0 if score #rdx br.tmp < #rbest br.tmp run data modify storage oa:supply region set value "コーラスの林のあたり"
execute if score #sv1 oa.map2 matches 0 if score #rdx br.tmp < #rbest br.tmp run scoreboard players operation #rbest br.tmp = #rdx br.tmp
execute if score #sv2 oa.map2 matches 0 run scoreboard players operation #rdx br.tmp = #rx br.tmp
execute if score #sv2 oa.map2 matches 0 run scoreboard players add #rdx br.tmp 3
execute if score #sv2 oa.map2 matches 0 run scoreboard players operation #rdx br.tmp *= #rdx br.tmp
execute if score #sv2 oa.map2 matches 0 run scoreboard players operation #rdz br.tmp = #rz br.tmp
execute if score #sv2 oa.map2 matches 0 run scoreboard players remove #rdz br.tmp 82
execute if score #sv2 oa.map2 matches 0 run scoreboard players operation #rdz br.tmp *= #rdz br.tmp
execute if score #sv2 oa.map2 matches 0 run scoreboard players operation #rdx br.tmp += #rdz br.tmp
execute if score #sv2 oa.map2 matches 0 if score #rdx br.tmp < #rbest br.tmp run data modify storage oa:supply region set value "崩れたエンドシティのあたり"
execute if score #sv2 oa.map2 matches 0 if score #rdx br.tmp < #rbest br.tmp run scoreboard players operation #rbest br.tmp = #rdx br.tmp
execute if score #sv3 oa.map2 matches 0 run scoreboard players operation #rdx br.tmp = #rx br.tmp
execute if score #sv3 oa.map2 matches 0 run scoreboard players add #rdx br.tmp 54
execute if score #sv3 oa.map2 matches 0 run scoreboard players operation #rdx br.tmp *= #rdx br.tmp
execute if score #sv3 oa.map2 matches 0 run scoreboard players operation #rdz br.tmp = #rz br.tmp
execute if score #sv3 oa.map2 matches 0 run scoreboard players remove #rdz br.tmp 64
execute if score #sv3 oa.map2 matches 0 run scoreboard players operation #rdz br.tmp *= #rdz br.tmp
execute if score #sv3 oa.map2 matches 0 run scoreboard players operation #rdx br.tmp += #rdz br.tmp
execute if score #sv3 oa.map2 matches 0 if score #rdx br.tmp < #rbest br.tmp run data modify storage oa:supply region set value "異界の塔街のあたり"
execute if score #sv3 oa.map2 matches 0 if score #rdx br.tmp < #rbest br.tmp run scoreboard players operation #rbest br.tmp = #rdx br.tmp
execute if score #sv4 oa.map2 matches 0 run scoreboard players operation #rdx br.tmp = #rx br.tmp
execute if score #sv4 oa.map2 matches 0 run scoreboard players add #rdx br.tmp 76
execute if score #sv4 oa.map2 matches 0 run scoreboard players operation #rdx br.tmp *= #rdx br.tmp
execute if score #sv4 oa.map2 matches 0 run scoreboard players operation #rdz br.tmp = #rz br.tmp
execute if score #sv4 oa.map2 matches 0 run scoreboard players add #rdz br.tmp 4
execute if score #sv4 oa.map2 matches 0 run scoreboard players operation #rdz br.tmp *= #rdz br.tmp
execute if score #sv4 oa.map2 matches 0 run scoreboard players operation #rdx br.tmp += #rdz br.tmp
execute if score #sv4 oa.map2 matches 0 if score #rdx br.tmp < #rbest br.tmp run data modify storage oa:supply region set value "結晶の洞窟のあたり"
execute if score #sv4 oa.map2 matches 0 if score #rdx br.tmp < #rbest br.tmp run scoreboard players operation #rbest br.tmp = #rdx br.tmp
execute if score #sv5 oa.map2 matches 0 run scoreboard players operation #rdx br.tmp = #rx br.tmp
execute if score #sv5 oa.map2 matches 0 run scoreboard players add #rdx br.tmp 54
execute if score #sv5 oa.map2 matches 0 run scoreboard players operation #rdx br.tmp *= #rdx br.tmp
execute if score #sv5 oa.map2 matches 0 run scoreboard players operation #rdz br.tmp = #rz br.tmp
execute if score #sv5 oa.map2 matches 0 run scoreboard players add #rdz br.tmp 54
execute if score #sv5 oa.map2 matches 0 run scoreboard players operation #rdz br.tmp *= #rdz br.tmp
execute if score #sv5 oa.map2 matches 0 run scoreboard players operation #rdx br.tmp += #rdz br.tmp
execute if score #sv5 oa.map2 matches 0 if score #rdx br.tmp < #rbest br.tmp run data modify storage oa:supply region set value "コーラスの林のあたり"
execute if score #sv5 oa.map2 matches 0 if score #rdx br.tmp < #rbest br.tmp run scoreboard players operation #rbest br.tmp = #rdx br.tmp
execute if score #sv6 oa.map2 matches 0 run scoreboard players operation #rdx br.tmp = #rx br.tmp
execute if score #sv6 oa.map2 matches 0 run scoreboard players remove #rdx br.tmp 2
execute if score #sv6 oa.map2 matches 0 run scoreboard players operation #rdx br.tmp *= #rdx br.tmp
execute if score #sv6 oa.map2 matches 0 run scoreboard players operation #rdz br.tmp = #rz br.tmp
execute if score #sv6 oa.map2 matches 0 run scoreboard players add #rdz br.tmp 77
execute if score #sv6 oa.map2 matches 0 run scoreboard players operation #rdz br.tmp *= #rdz br.tmp
execute if score #sv6 oa.map2 matches 0 run scoreboard players operation #rdx br.tmp += #rdz br.tmp
execute if score #sv6 oa.map2 matches 0 if score #rdx br.tmp < #rbest br.tmp run data modify storage oa:supply region set value "異界の塔街のあたり"
execute if score #sv6 oa.map2 matches 0 if score #rdx br.tmp < #rbest br.tmp run scoreboard players operation #rbest br.tmp = #rdx br.tmp
execute if score #sv7 oa.map2 matches 0 run scoreboard players operation #rdx br.tmp = #rx br.tmp
execute if score #sv7 oa.map2 matches 0 run scoreboard players remove #rdx br.tmp 57
execute if score #sv7 oa.map2 matches 0 run scoreboard players operation #rdx br.tmp *= #rdx br.tmp
execute if score #sv7 oa.map2 matches 0 run scoreboard players operation #rdz br.tmp = #rz br.tmp
execute if score #sv7 oa.map2 matches 0 run scoreboard players add #rdz br.tmp 52
execute if score #sv7 oa.map2 matches 0 run scoreboard players operation #rdz br.tmp *= #rdz br.tmp
execute if score #sv7 oa.map2 matches 0 run scoreboard players operation #rdx br.tmp += #rdz br.tmp
execute if score #sv7 oa.map2 matches 0 if score #rdx br.tmp < #rbest br.tmp run data modify storage oa:supply region set value "黒曜石の森のあたり"
execute if score #sv7 oa.map2 matches 0 if score #rdx br.tmp < #rbest br.tmp run scoreboard players operation #rbest br.tmp = #rdx br.tmp
