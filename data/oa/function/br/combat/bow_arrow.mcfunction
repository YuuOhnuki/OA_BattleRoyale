tag @s add oa.bow_checked
scoreboard players set #bow_player br.flag 0
execute on origin if entity @s[type=minecraft:player,tag=br.playing] run scoreboard players set #bow_player br.flag 1
execute unless score #bow_player br.flag matches 1 run return 0
scoreboard players set #bow_damage br.tmp 2000000
execute if data entity @s damage store result score #bow_damage br.tmp run data get entity @s damage 1000000
execute store result entity @s damage double 0.00000075 run scoreboard players get #bow_damage br.tmp
