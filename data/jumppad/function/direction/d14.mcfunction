# ============================================================
# ジャンプ方向 -45.0度
# 水平初速 2.50 block/tick
# 垂直初速 1.00 block/tick
# ============================================================

summon minecraft:armor_stand ~ ~-0.95 ~ {Tags:["jp_vehicle"],Invisible:1b,Small:1b,Invulnerable:1b,NoBasePlate:1b,Silent:1b,PersistenceRequired:1b,Motion:[1.767767d,1.000000d,1.767767d]}

scoreboard players set @e[type=minecraft:armor_stand,tag=jp_vehicle,distance=..2,limit=1,sort=nearest] jp_age 0

ride @s mount @e[type=minecraft:armor_stand,tag=jp_vehicle,distance=..2,limit=1,sort=nearest]
