# 1.9.187: 着地したので外す（fish/fall_guard から。死亡・退出時も internal/cleanup から）
attribute @s minecraft:fall_damage_multiplier modifier remove oa:fish_fall
tag @s remove oa.fish_fall
scoreboard players set @s oa.ffall 0
