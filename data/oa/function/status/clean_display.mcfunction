data remove entity @s item.components."minecraft:custom_data".oa_receiver
scoreboard players set #keys oa.tmp 0
execute store result score #keys oa.tmp run data get entity @s item.components."minecraft:custom_data"
execute if score #keys oa.tmp matches 0 run data remove entity @s item.components."minecraft:custom_data"
scoreboard players set #keys oa.tmp 0
execute store result score #keys oa.tmp run data get entity @s item.components."minecraft:enchantments"
execute if score #keys oa.tmp matches 0 run data remove entity @s item.components."minecraft:enchantments"
