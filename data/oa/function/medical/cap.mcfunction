attribute @s minecraft:max_health modifier remove oa:medical_cap
$attribute @s minecraft:max_health modifier add oa:medical_cap $(cap) add_value
effect give @s minecraft:instant_health 1 10 true
attribute @s minecraft:max_health modifier remove oa:medical_cap
