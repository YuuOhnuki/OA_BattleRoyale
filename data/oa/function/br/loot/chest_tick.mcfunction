execute unless block ~ ~ ~ minecraft:chest[type=single] run return 0
execute unless score @s br.round = #round br.round run function oa:br/loot/chest_initial
execute if score #time br.time matches 7200.. if score @s br.cstage matches 0 run function oa:br/loot/chest_upgrade
# 1.9.160: 特別チェストは金色の光の粒で見分けられるようにする（試合中、0.5秒ごと。近く24ブロックの人にだけ見える）
execute if entity @s[tag=br.rich] run particle minecraft:dust{color:[1.0,0.78,0.1],scale:1.3} ~ ~0.6 ~ 0.35 0.3 0.35 0 3 normal @a[distance=..24]
execute if entity @s[tag=br.rich] run particle minecraft:wax_on ~ ~0.9 ~ 0.3 0.2 0.3 0 1 normal @a[distance=..24]
