# 1.9.191: 爆速。止まれない（向いている方向へ進み続ける）のはプラグイン（weapon/RushService、タグ oa.gacha_rush）
attribute @s minecraft:movement_speed modifier remove oa:gacha_rush
attribute @s minecraft:movement_speed modifier add oa:gacha_rush 1.0 add_multiplied_total
scoreboard players set @s oa.grush 200
tag @s add oa.gacha_rush
tag @s add oa.gacha_affected
particle minecraft:cloud ~ ~0.5 ~ 0.4 0.2 0.4 0.05 16 normal @a[distance=..32]
playsound minecraft:entity.breeze.wind_burst player @a[distance=..32] ~ ~ ~ 1 1.2
