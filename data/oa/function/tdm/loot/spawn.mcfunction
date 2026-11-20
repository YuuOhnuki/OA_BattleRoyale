scoreboard players operation #node_slot tdm.slot = @s tdm.slot
execute as @e[tag=tdm.pickup] if score @s tdm.slot = #node_slot tdm.slot run kill @s
summon minecraft:item_display ~ ~0.6 ~ {Tags:["tdm.pickup","tdm.fresh"],billboard:"center",Glowing:1b,view_range:0.6f}
scoreboard players operation @e[tag=tdm.fresh] tdm.slot = @s tdm.slot
scoreboard players operation @e[tag=tdm.fresh] tdm.type = @s tdm.type
execute if score @s tdm.type matches 0 run function oa:tdm/loot/weapon_roll
execute if score @s tdm.type matches 101 run item replace entity @e[tag=tdm.fresh,limit=1] contents with minecraft:iron_chestplate
execute if score @s tdm.type matches 102 run item replace entity @e[tag=tdm.fresh,limit=1] contents with minecraft:diamond_chestplate
execute if score @s tdm.type matches 102 run tellraw @a[tag=tdm.player] {text:"中央にダイヤ防具強化が出現！",color:"aqua"}
scoreboard players set @s tdm.cool 600
execute if score @s tdm.type matches 102 run scoreboard players set @s tdm.cool 1200
tag @e[tag=tdm.fresh] remove tdm.fresh
particle minecraft:happy_villager ~ ~1 ~ 0.3 0.3 0.3 0 8 normal @a[distance=..32]
