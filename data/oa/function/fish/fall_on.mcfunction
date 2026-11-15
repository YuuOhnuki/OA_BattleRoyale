# 1.9.187: 落下ダメージを0に（fish/fall_guard から）
attribute @s minecraft:fall_damage_multiplier modifier remove oa:fish_fall
attribute @s minecraft:fall_damage_multiplier modifier add oa:fish_fall -1 add_multiplied_total
tag @s add oa.fish_fall
scoreboard players set @s oa.ffall 0
