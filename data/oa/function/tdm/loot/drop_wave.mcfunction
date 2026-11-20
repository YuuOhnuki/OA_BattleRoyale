scoreboard players set #drops tdm.sys 0
execute as @e[tag=tdm.pickup] run scoreboard players add #drops tdm.sys 1
execute if score #drops tdm.sys matches 14.. run return 0
execute as @e[tag=tdm.loot_point,sort=random,limit=1] at @s run function oa:tdm/loot/random_weapon
execute as @e[tag=tdm.loot_point,sort=random,limit=1] at @s run function oa:tdm/loot/random_weapon
execute store result score #armor_roll tdm.sys run random value 1..4
execute if score #armor_roll tdm.sys matches 1..2 as @e[tag=tdm.loot_point,sort=random,limit=1] at @s run function oa:tdm/loot/iron
execute if score #armor_roll tdm.sys matches 3 as @e[tag=tdm.loot_point,sort=random,limit=1] at @s run function oa:tdm/loot/diamond
