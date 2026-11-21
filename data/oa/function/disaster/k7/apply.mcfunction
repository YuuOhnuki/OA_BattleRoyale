# 重力 −50%・跳躍力 +0.25（ほかの仕組みとは別の名前 oa:dis_gravity なので、固有武器の属性を上書きしない）
execute unless entity @s[tag=oa.dis_grav] run attribute @s minecraft:gravity modifier add oa:dis_gravity -0.5 add_multiplied_total
execute unless entity @s[tag=oa.dis_grav] run attribute @s minecraft:jump_strength modifier add oa:dis_gravity 0.25 add_value
tag @s add oa.dis_grav
# 落下ダメージ無効は、終わってから4秒まで残す（着地まで）
scoreboard players set @s br.dfall 4
execute unless entity @s[tag=oa.dis_fall] run function oa:disaster/fall_on
particle minecraft:end_rod ~ ~0.2 ~ 0.4 0.1 0.4 0.02 2 normal @a[distance=..24]
# ときどき少しだけ浮く（竜巻で打ち上げられている人は除く。浮遊I 1秒）
execute unless entity @s[tag=oa.dis_air] if predicate oa:dis/chance20 run effect give @s minecraft:levitation 1 0 true
