execute unless data entity @s Health run return 0
execute unless score @s oa.id matches 1.. run function oa:internal/id
tag @s add oa.debug_mob
scoreboard players set @s oa.team 0
scoreboard players set @s oa.hop 0
scoreboard players set @s oa.hoparc 0
scoreboard players set @s oa.root 0
scoreboard players set @s oa.bleed 0
execute store result score @s oa.db_hp run data get entity @s Health 1000
