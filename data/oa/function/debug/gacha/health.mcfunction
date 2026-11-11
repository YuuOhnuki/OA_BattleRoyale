execute unless entity @s[tag=oa.debug_mob] run return run function oa:tayayuyu/health
attribute @s minecraft:max_health modifier remove oa:gacha_hp
attribute @s minecraft:max_health modifier add oa:gacha_hp 20 add_value
scoreboard players set @s oa.ghp 300
execute store result score #db_hp oa.tmp run data get entity @s Health 1000
scoreboard players add #db_hp oa.tmp 20000
execute store result score #db_max oa.tmp run attribute @s minecraft:max_health get 1000
execute if score #db_hp oa.tmp > #db_max oa.tmp run scoreboard players operation #db_hp oa.tmp = #db_max oa.tmp
execute store result entity @s Health float 0.001 run scoreboard players get #db_hp oa.tmp
tag @s add oa.gacha_affected
tag @s add oa.gacha_hp
