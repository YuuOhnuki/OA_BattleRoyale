summon minecraft:item_display ~ ~0.5 ~ {Tags:["tdm.pickup","tdm.saved","tdm.old_new"],billboard:"center",Glowing:1b,view_range:0.8f}
$execute store success score #drop_ok tdm.sys run item replace entity @e[tag=tdm.old_new,limit=1] contents from entity @s $(slot)
execute unless score #drop_ok tdm.sys matches 1 run kill @e[tag=tdm.old_new]
execute unless score #drop_ok tdm.sys matches 1 run return 0
execute store result score @e[tag=tdm.old_new,limit=1] tdm.type run data get entity @e[tag=tdm.old_new,limit=1] item.components."minecraft:custom_data".oa.kind
scoreboard players set @e[tag=tdm.old_new] tdm.cool 800
scoreboard players set @e[tag=tdm.old_new] tdm.lock 20
execute as @e[tag=tdm.old_new,limit=1] at @s run function oa:tdm/loot/label
tag @e[tag=tdm.old_new] remove tdm.old_new
