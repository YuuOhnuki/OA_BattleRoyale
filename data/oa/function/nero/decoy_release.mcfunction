scoreboard players set #decoy_peace_restore oa.tmp 0
execute if entity @s[tag=oa.gacha_peace,tag=oa.self_decoy] run scoreboard players set #decoy_peace_restore oa.tmp 1
execute if entity @s[tag=oa.gacha_peace,tag=oa.decoy_grace] run scoreboard players set #decoy_peace_restore oa.tmp 1
execute if entity @s[tag=oa.self_decoy] run effect clear @s minecraft:resistance
execute if entity @s[tag=oa.decoy_grace] run effect clear @s minecraft:resistance
attribute @s minecraft:attack_damage modifier remove oa:decoy_disarm
attribute @s minecraft:knockback_resistance modifier remove oa:decoy_guard
tag @s remove oa.self_decoy
tag @s remove oa.decoy_grace
scoreboard players set @s oa.decoy 0
advancement revoke @s only oa:nero/decoy_hit

execute if score #decoy_peace_restore oa.tmp matches 1 if score @s oa.gpeace matches 1.. run function oa:tayayuyu/refresh_peace
