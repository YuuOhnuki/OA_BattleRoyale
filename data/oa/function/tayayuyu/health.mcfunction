attribute @s minecraft:max_health modifier remove oa:gacha_hp
attribute @s minecraft:max_health modifier add oa:gacha_hp 20 add_value
scoreboard players set @s oa.ghp 300
function oa:medical/heal {milli:20000}

tag @s add oa.gacha_affected

tag @s add oa.gacha_hp
