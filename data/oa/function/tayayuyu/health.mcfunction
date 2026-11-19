attribute @s minecraft:max_health modifier remove oa:gacha_hp
attribute @s minecraft:max_health modifier add oa:gacha_hp 20 add_value
scoreboard players set @s oa.ghp 900
# 1.9.191: 45秒。移動速度上昇II・再生I・跳躍力上昇II
effect give @s minecraft:speed 45 1 true
effect give @s minecraft:regeneration 45 0 true
effect give @s minecraft:jump_boost 45 1 true
function oa:medical/heal {milli:20000}

tag @s add oa.gacha_affected

tag @s add oa.gacha_hp
