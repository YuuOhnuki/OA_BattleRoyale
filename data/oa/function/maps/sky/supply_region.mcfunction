# 生成: scripts/build_map_sky.py（直接編集しない）。空中補給の場所名（#rx,#rz は中心からの相対）。中央か、置かれた島のうちいちばん近い所
scoreboard players set #rbest br.tmp 2147483647
data modify storage oa:supply region set value "天空島"
scoreboard players operation #rdx br.tmp = #rx br.tmp
scoreboard players remove #rdx br.tmp 0
scoreboard players operation #rdx br.tmp *= #rdx br.tmp
scoreboard players operation #rdz br.tmp = #rz br.tmp
scoreboard players remove #rdz br.tmp 0
scoreboard players operation #rdz br.tmp *= #rdz br.tmp
scoreboard players operation #rdx br.tmp += #rdz br.tmp
execute if score #rdx br.tmp < #rbest br.tmp run data modify storage oa:supply region set value "天空城のあたり"
execute if score #rdx br.tmp < #rbest br.tmp run scoreboard players operation #rbest br.tmp = #rdx br.tmp
execute unless score #sk0 oa.map2 matches -1 run scoreboard players operation #rdx br.tmp = #rx br.tmp
execute unless score #sk0 oa.map2 matches -1 run scoreboard players remove #rdx br.tmp 109
execute unless score #sk0 oa.map2 matches -1 run scoreboard players operation #rdx br.tmp *= #rdx br.tmp
execute unless score #sk0 oa.map2 matches -1 run scoreboard players operation #rdz br.tmp = #rz br.tmp
execute unless score #sk0 oa.map2 matches -1 run scoreboard players remove #rdz br.tmp 17
execute unless score #sk0 oa.map2 matches -1 run scoreboard players operation #rdz br.tmp *= #rdz br.tmp
execute unless score #sk0 oa.map2 matches -1 run scoreboard players operation #rdx br.tmp += #rdz br.tmp
execute unless score #sk0 oa.map2 matches -1 if score #rdx br.tmp < #rbest br.tmp run data modify storage oa:supply region set from storage oa:maps sky_region.s0
execute unless score #sk0 oa.map2 matches -1 if score #rdx br.tmp < #rbest br.tmp run scoreboard players operation #rbest br.tmp = #rdx br.tmp
execute unless score #sk1 oa.map2 matches -1 run scoreboard players operation #rdx br.tmp = #rx br.tmp
execute unless score #sk1 oa.map2 matches -1 run scoreboard players remove #rdx br.tmp 86
execute unless score #sk1 oa.map2 matches -1 run scoreboard players operation #rdx br.tmp *= #rdx br.tmp
execute unless score #sk1 oa.map2 matches -1 run scoreboard players operation #rdz br.tmp = #rz br.tmp
execute unless score #sk1 oa.map2 matches -1 run scoreboard players remove #rdz br.tmp 86
execute unless score #sk1 oa.map2 matches -1 run scoreboard players operation #rdz br.tmp *= #rdz br.tmp
execute unless score #sk1 oa.map2 matches -1 run scoreboard players operation #rdx br.tmp += #rdz br.tmp
execute unless score #sk1 oa.map2 matches -1 if score #rdx br.tmp < #rbest br.tmp run data modify storage oa:supply region set from storage oa:maps sky_region.s1
execute unless score #sk1 oa.map2 matches -1 if score #rdx br.tmp < #rbest br.tmp run scoreboard players operation #rbest br.tmp = #rdx br.tmp
execute unless score #sk2 oa.map2 matches -1 run scoreboard players operation #rdx br.tmp = #rx br.tmp
execute unless score #sk2 oa.map2 matches -1 run scoreboard players remove #rdx br.tmp 17
execute unless score #sk2 oa.map2 matches -1 run scoreboard players operation #rdx br.tmp *= #rdx br.tmp
execute unless score #sk2 oa.map2 matches -1 run scoreboard players operation #rdz br.tmp = #rz br.tmp
execute unless score #sk2 oa.map2 matches -1 run scoreboard players remove #rdz br.tmp 109
execute unless score #sk2 oa.map2 matches -1 run scoreboard players operation #rdz br.tmp *= #rdz br.tmp
execute unless score #sk2 oa.map2 matches -1 run scoreboard players operation #rdx br.tmp += #rdz br.tmp
execute unless score #sk2 oa.map2 matches -1 if score #rdx br.tmp < #rbest br.tmp run data modify storage oa:supply region set from storage oa:maps sky_region.s2
execute unless score #sk2 oa.map2 matches -1 if score #rdx br.tmp < #rbest br.tmp run scoreboard players operation #rbest br.tmp = #rdx br.tmp
execute unless score #sk3 oa.map2 matches -1 run scoreboard players operation #rdx br.tmp = #rx br.tmp
execute unless score #sk3 oa.map2 matches -1 run scoreboard players add #rdx br.tmp 55
execute unless score #sk3 oa.map2 matches -1 run scoreboard players operation #rdx br.tmp *= #rdx br.tmp
execute unless score #sk3 oa.map2 matches -1 run scoreboard players operation #rdz br.tmp = #rz br.tmp
execute unless score #sk3 oa.map2 matches -1 run scoreboard players remove #rdz br.tmp 109
execute unless score #sk3 oa.map2 matches -1 run scoreboard players operation #rdz br.tmp *= #rdz br.tmp
execute unless score #sk3 oa.map2 matches -1 run scoreboard players operation #rdx br.tmp += #rdz br.tmp
execute unless score #sk3 oa.map2 matches -1 if score #rdx br.tmp < #rbest br.tmp run data modify storage oa:supply region set from storage oa:maps sky_region.s3
execute unless score #sk3 oa.map2 matches -1 if score #rdx br.tmp < #rbest br.tmp run scoreboard players operation #rbest br.tmp = #rdx br.tmp
execute unless score #sk4 oa.map2 matches -1 run scoreboard players operation #rdx br.tmp = #rx br.tmp
execute unless score #sk4 oa.map2 matches -1 run scoreboard players add #rdx br.tmp 98
execute unless score #sk4 oa.map2 matches -1 run scoreboard players operation #rdx br.tmp *= #rdx br.tmp
execute unless score #sk4 oa.map2 matches -1 run scoreboard players operation #rdz br.tmp = #rz br.tmp
execute unless score #sk4 oa.map2 matches -1 run scoreboard players remove #rdz br.tmp 50
execute unless score #sk4 oa.map2 matches -1 run scoreboard players operation #rdz br.tmp *= #rdz br.tmp
execute unless score #sk4 oa.map2 matches -1 run scoreboard players operation #rdx br.tmp += #rdz br.tmp
execute unless score #sk4 oa.map2 matches -1 if score #rdx br.tmp < #rbest br.tmp run data modify storage oa:supply region set from storage oa:maps sky_region.s4
execute unless score #sk4 oa.map2 matches -1 if score #rdx br.tmp < #rbest br.tmp run scoreboard players operation #rbest br.tmp = #rdx br.tmp
execute unless score #sk5 oa.map2 matches -1 run scoreboard players operation #rdx br.tmp = #rx br.tmp
execute unless score #sk5 oa.map2 matches -1 run scoreboard players add #rdx br.tmp 120
execute unless score #sk5 oa.map2 matches -1 run scoreboard players operation #rdx br.tmp *= #rdx br.tmp
execute unless score #sk5 oa.map2 matches -1 run scoreboard players operation #rdz br.tmp = #rz br.tmp
execute unless score #sk5 oa.map2 matches -1 run scoreboard players add #rdz br.tmp 19
execute unless score #sk5 oa.map2 matches -1 run scoreboard players operation #rdz br.tmp *= #rdz br.tmp
execute unless score #sk5 oa.map2 matches -1 run scoreboard players operation #rdx br.tmp += #rdz br.tmp
execute unless score #sk5 oa.map2 matches -1 if score #rdx br.tmp < #rbest br.tmp run data modify storage oa:supply region set from storage oa:maps sky_region.s5
execute unless score #sk5 oa.map2 matches -1 if score #rdx br.tmp < #rbest br.tmp run scoreboard players operation #rbest br.tmp = #rdx br.tmp
execute unless score #sk6 oa.map2 matches -1 run scoreboard players operation #rdx br.tmp = #rx br.tmp
execute unless score #sk6 oa.map2 matches -1 run scoreboard players add #rdx br.tmp 78
execute unless score #sk6 oa.map2 matches -1 run scoreboard players operation #rdx br.tmp *= #rdx br.tmp
execute unless score #sk6 oa.map2 matches -1 run scoreboard players operation #rdz br.tmp = #rz br.tmp
execute unless score #sk6 oa.map2 matches -1 run scoreboard players add #rdz br.tmp 78
execute unless score #sk6 oa.map2 matches -1 run scoreboard players operation #rdz br.tmp *= #rdz br.tmp
execute unless score #sk6 oa.map2 matches -1 run scoreboard players operation #rdx br.tmp += #rdz br.tmp
execute unless score #sk6 oa.map2 matches -1 if score #rdx br.tmp < #rbest br.tmp run data modify storage oa:supply region set from storage oa:maps sky_region.s6
execute unless score #sk6 oa.map2 matches -1 if score #rdx br.tmp < #rbest br.tmp run scoreboard players operation #rbest br.tmp = #rdx br.tmp
execute unless score #sk7 oa.map2 matches -1 run scoreboard players operation #rdx br.tmp = #rx br.tmp
execute unless score #sk7 oa.map2 matches -1 run scoreboard players add #rdx br.tmp 19
execute unless score #sk7 oa.map2 matches -1 run scoreboard players operation #rdx br.tmp *= #rdx br.tmp
execute unless score #sk7 oa.map2 matches -1 run scoreboard players operation #rdz br.tmp = #rz br.tmp
execute unless score #sk7 oa.map2 matches -1 run scoreboard players add #rdz br.tmp 120
execute unless score #sk7 oa.map2 matches -1 run scoreboard players operation #rdz br.tmp *= #rdz br.tmp
execute unless score #sk7 oa.map2 matches -1 run scoreboard players operation #rdx br.tmp += #rdz br.tmp
execute unless score #sk7 oa.map2 matches -1 if score #rdx br.tmp < #rbest br.tmp run data modify storage oa:supply region set from storage oa:maps sky_region.s7
execute unless score #sk7 oa.map2 matches -1 if score #rdx br.tmp < #rbest br.tmp run scoreboard players operation #rbest br.tmp = #rdx br.tmp
execute unless score #sk8 oa.map2 matches -1 run scoreboard players operation #rdx br.tmp = #rx br.tmp
execute unless score #sk8 oa.map2 matches -1 run scoreboard players remove #rdx br.tmp 50
execute unless score #sk8 oa.map2 matches -1 run scoreboard players operation #rdx br.tmp *= #rdx br.tmp
execute unless score #sk8 oa.map2 matches -1 run scoreboard players operation #rdz br.tmp = #rz br.tmp
execute unless score #sk8 oa.map2 matches -1 run scoreboard players add #rdz br.tmp 98
execute unless score #sk8 oa.map2 matches -1 run scoreboard players operation #rdz br.tmp *= #rdz br.tmp
execute unless score #sk8 oa.map2 matches -1 run scoreboard players operation #rdx br.tmp += #rdz br.tmp
execute unless score #sk8 oa.map2 matches -1 if score #rdx br.tmp < #rbest br.tmp run data modify storage oa:supply region set from storage oa:maps sky_region.s8
execute unless score #sk8 oa.map2 matches -1 if score #rdx br.tmp < #rbest br.tmp run scoreboard players operation #rbest br.tmp = #rdx br.tmp
execute unless score #sk9 oa.map2 matches -1 run scoreboard players operation #rdx br.tmp = #rx br.tmp
execute unless score #sk9 oa.map2 matches -1 run scoreboard players remove #rdx br.tmp 109
execute unless score #sk9 oa.map2 matches -1 run scoreboard players operation #rdx br.tmp *= #rdx br.tmp
execute unless score #sk9 oa.map2 matches -1 run scoreboard players operation #rdz br.tmp = #rz br.tmp
execute unless score #sk9 oa.map2 matches -1 run scoreboard players add #rdz br.tmp 55
execute unless score #sk9 oa.map2 matches -1 run scoreboard players operation #rdz br.tmp *= #rdz br.tmp
execute unless score #sk9 oa.map2 matches -1 run scoreboard players operation #rdx br.tmp += #rdz br.tmp
execute unless score #sk9 oa.map2 matches -1 if score #rdx br.tmp < #rbest br.tmp run data modify storage oa:supply region set from storage oa:maps sky_region.s9
execute unless score #sk9 oa.map2 matches -1 if score #rdx br.tmp < #rbest br.tmp run scoreboard players operation #rbest br.tmp = #rdx br.tmp
