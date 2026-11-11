tag @s remove oa.db_free_cd
execute if score @s oa.db_cd matches 0 run tag @s add oa.db_free_cd
tag @s remove oa.db_multi
execute if score @s oa.db_unique matches 0 run tag @s add oa.db_multi
tag @s remove oa.db_free_match
execute if score @s oa.db_match matches 0 run tag @s add oa.db_free_match
tag @s remove oa.db_free_grace
execute if score @s oa.db_grace matches 0 run tag @s add oa.db_free_grace
tag @s remove oa.db_friendly
execute if score @s oa.db_team matches 0 run tag @s add oa.db_friendly
tag @s remove oa.db_infinite
execute if score @s oa.db_consume matches 0 run tag @s add oa.db_infinite
tag @s remove oa.db_keepwear
execute if score @s oa.db_wear matches 0 run tag @s add oa.db_keepwear
tag @s remove oa.db_unbind
execute if score @s oa.db_bind matches 0 run tag @s add oa.db_unbind
tag @s remove oa.db_mobs
execute if score @s oa.db_mobs matches 1 run tag @s add oa.db_mobs
tag @s remove oa.db_heal
execute if score @s oa.db_heal matches 1 run tag @s add oa.db_heal
