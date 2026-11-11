scoreboard players set #db_hp br.tmp 0
execute store result score #db_hp br.tmp run data get entity @s Health 1000
execute unless score @s oa.db_hp matches 0.. run scoreboard players operation @s oa.db_hp = #db_hp br.tmp
scoreboard players operation #db_lost br.tmp = @s oa.db_hp
scoreboard players operation #db_lost br.tmp -= #db_hp br.tmp
scoreboard players operation @s oa.db_hp = #db_hp br.tmp
execute if score #db_lost br.tmp matches 1.. run function oa:debug/damage_show
