# 1.9.213: 足の高さ（~0.1）が土の道・耕地・ソウルサンド・泥・雪・カーペット・下付きハーフブロックなど高さ1未満の床なら、その上に立っているとみなす（#oa:low_floor）
scoreboard players set #spawn_floor br.flag 1
execute unless loaded ~ ~ ~ run return run scoreboard players set #spawn_floor br.flag 0
execute if entity @e[type=minecraft:marker,tag=br.spawn,tag=!br.spawn_check,distance=..24] run return run scoreboard players set #spawn_floor br.flag 0
execute if block ~-0.3 ~-0.1 ~-0.3 #oa:spawn_clear run return run scoreboard players set #spawn_floor br.flag 0
execute if block ~-0.3 ~-0.1 ~-0.3 #oa:spawn_unsafe_floor run return run scoreboard players set #spawn_floor br.flag 0
execute unless block ~-0.3 ~0.1 ~-0.3 #oa:spawn_clear unless block ~-0.3 ~0.1 ~-0.3 #oa:low_floor unless block ~-0.3 ~0.1 ~-0.3 #minecraft:slabs[type=bottom] run return run scoreboard players set #spawn_floor br.flag 0
execute unless block ~-0.3 ~1 ~-0.3 #oa:spawn_clear run return run scoreboard players set #spawn_floor br.flag 0
execute unless block ~-0.3 ~1.9 ~-0.3 #oa:spawn_clear run return run scoreboard players set #spawn_floor br.flag 0
execute if block ~-0.3 ~-0.1 ~0.3 #oa:spawn_clear run return run scoreboard players set #spawn_floor br.flag 0
execute if block ~-0.3 ~-0.1 ~0.3 #oa:spawn_unsafe_floor run return run scoreboard players set #spawn_floor br.flag 0
execute unless block ~-0.3 ~0.1 ~0.3 #oa:spawn_clear unless block ~-0.3 ~0.1 ~0.3 #oa:low_floor unless block ~-0.3 ~0.1 ~0.3 #minecraft:slabs[type=bottom] run return run scoreboard players set #spawn_floor br.flag 0
execute unless block ~-0.3 ~1 ~0.3 #oa:spawn_clear run return run scoreboard players set #spawn_floor br.flag 0
execute unless block ~-0.3 ~1.9 ~0.3 #oa:spawn_clear run return run scoreboard players set #spawn_floor br.flag 0
execute if block ~0.3 ~-0.1 ~-0.3 #oa:spawn_clear run return run scoreboard players set #spawn_floor br.flag 0
execute if block ~0.3 ~-0.1 ~-0.3 #oa:spawn_unsafe_floor run return run scoreboard players set #spawn_floor br.flag 0
execute unless block ~0.3 ~0.1 ~-0.3 #oa:spawn_clear unless block ~0.3 ~0.1 ~-0.3 #oa:low_floor unless block ~0.3 ~0.1 ~-0.3 #minecraft:slabs[type=bottom] run return run scoreboard players set #spawn_floor br.flag 0
execute unless block ~0.3 ~1 ~-0.3 #oa:spawn_clear run return run scoreboard players set #spawn_floor br.flag 0
execute unless block ~0.3 ~1.9 ~-0.3 #oa:spawn_clear run return run scoreboard players set #spawn_floor br.flag 0
execute if block ~0.3 ~-0.1 ~0.3 #oa:spawn_clear run return run scoreboard players set #spawn_floor br.flag 0
execute if block ~0.3 ~-0.1 ~0.3 #oa:spawn_unsafe_floor run return run scoreboard players set #spawn_floor br.flag 0
execute unless block ~0.3 ~0.1 ~0.3 #oa:spawn_clear unless block ~0.3 ~0.1 ~0.3 #oa:low_floor unless block ~0.3 ~0.1 ~0.3 #minecraft:slabs[type=bottom] run return run scoreboard players set #spawn_floor br.flag 0
execute unless block ~0.3 ~1 ~0.3 #oa:spawn_clear run return run scoreboard players set #spawn_floor br.flag 0
execute unless block ~0.3 ~1.9 ~0.3 #oa:spawn_clear run return run scoreboard players set #spawn_floor br.flag 0
