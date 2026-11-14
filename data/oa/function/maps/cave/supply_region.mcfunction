# 生成: scripts/build_map_cave.py（直接編集しない）。洞窟会場の空中補給の場所名（中心からの相対座標 #rx,#rz は br/supply/region で計算済み）。いちばん近いエリアの名前
scoreboard players set #rbest br.tmp 2147483647
scoreboard players operation #rdx br.tmp = #rx br.tmp
scoreboard players remove #rdx br.tmp 91
scoreboard players operation #rdx br.tmp *= #rdx br.tmp
scoreboard players operation #rdz br.tmp = #rz br.tmp
scoreboard players remove #rdz br.tmp 30
scoreboard players operation #rdz br.tmp *= #rdz br.tmp
scoreboard players operation #rdx br.tmp += #rdz br.tmp
execute if score #rdx br.tmp < #rbest br.tmp run data modify storage oa:supply region set value "紫水晶の晶洞のあたり"
execute if score #rdx br.tmp < #rbest br.tmp run scoreboard players operation #rbest br.tmp = #rdx br.tmp
scoreboard players operation #rdx br.tmp = #rx br.tmp
scoreboard players remove #rdx br.tmp 0
scoreboard players operation #rdx br.tmp *= #rdx br.tmp
scoreboard players operation #rdz br.tmp = #rz br.tmp
scoreboard players remove #rdz br.tmp 98
scoreboard players operation #rdz br.tmp *= #rdz br.tmp
scoreboard players operation #rdx br.tmp += #rdz br.tmp
execute if score #rdx br.tmp < #rbest br.tmp run data modify storage oa:supply region set value "繁茂した洞窟のあたり"
execute if score #rdx br.tmp < #rbest br.tmp run scoreboard players operation #rbest br.tmp = #rdx br.tmp
scoreboard players operation #rdx br.tmp = #rx br.tmp
scoreboard players add #rdx br.tmp 93
scoreboard players operation #rdx br.tmp *= #rdx br.tmp
scoreboard players operation #rdz br.tmp = #rz br.tmp
scoreboard players remove #rdz br.tmp 30
scoreboard players operation #rdz br.tmp *= #rdz br.tmp
scoreboard players operation #rdx br.tmp += #rdz br.tmp
execute if score #rdx br.tmp < #rbest br.tmp run data modify storage oa:supply region set value "鍾乳洞と地底湖のあたり"
execute if score #rdx br.tmp < #rbest br.tmp run scoreboard players operation #rbest br.tmp = #rdx br.tmp
scoreboard players operation #rdx br.tmp = #rx br.tmp
scoreboard players add #rdx br.tmp 58
scoreboard players operation #rdx br.tmp *= #rdx br.tmp
scoreboard players operation #rdz br.tmp = #rz br.tmp
scoreboard players add #rdz br.tmp 79
scoreboard players operation #rdz br.tmp *= #rdz br.tmp
scoreboard players operation #rdx br.tmp += #rdz br.tmp
execute if score #rdx br.tmp < #rbest br.tmp run data modify storage oa:supply region set value "廃坑とディープダークのあたり"
execute if score #rdx br.tmp < #rbest br.tmp run scoreboard players operation #rbest br.tmp = #rdx br.tmp
scoreboard players operation #rdx br.tmp = #rx br.tmp
scoreboard players remove #rdx br.tmp 56
scoreboard players operation #rdx br.tmp *= #rdx br.tmp
scoreboard players operation #rdz br.tmp = #rz br.tmp
scoreboard players add #rdz br.tmp 78
scoreboard players operation #rdz br.tmp *= #rdz br.tmp
scoreboard players operation #rdx br.tmp += #rdz br.tmp
execute if score #rdx br.tmp < #rbest br.tmp run data modify storage oa:supply region set value "古代都市の町並みのあたり"
execute if score #rdx br.tmp < #rbest br.tmp run scoreboard players operation #rbest br.tmp = #rdx br.tmp
execute if score #rx br.tmp matches -27..27 if score #rz br.tmp matches -27..27 run data modify storage oa:supply region set value "地下神殿"
