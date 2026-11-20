execute store result score #hp tdm.sys run data get entity @s Health 10
execute store result score #hp_max tdm.sys run attribute @s minecraft:max_health get 10
execute store result score #food tdm.sys run data get entity @s foodLevel
execute if score #hp tdm.sys >= #hp_max tdm.sys if score #food tdm.sys matches 20.. run return 0
scoreboard players add @s tdm.heal 10
scoreboard players add @s tdm.food 10
function oa:tdm/fx/heal
execute as @e[tag=tdm.claim] run function oa:tdm/loot/remove
