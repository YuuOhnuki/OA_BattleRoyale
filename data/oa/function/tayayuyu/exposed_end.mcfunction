attribute @s minecraft:attack_damage modifier remove oa:gacha_exposed
attribute @s minecraft:entity_interaction_range modifier remove oa:gacha_exposed
scoreboard players set @s oa.gexpose 0
tag @s remove oa.gacha_exposed
tag @s remove oa.gacha_internal
tag @s remove oa.ex_extra
advancement revoke @s only oa:tayayuyu/exposed_hurt
