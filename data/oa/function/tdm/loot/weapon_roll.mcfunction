execute store result score #weapon_roll tdm.sys run random value 1..6
execute if score #weapon_roll tdm.sys matches 1 run scoreboard players set @e[tag=tdm.fresh] tdm.type 2
execute if score #weapon_roll tdm.sys matches 2 run scoreboard players set @e[tag=tdm.fresh] tdm.type 4
execute if score #weapon_roll tdm.sys matches 3 run scoreboard players set @e[tag=tdm.fresh] tdm.type 6
execute if score #weapon_roll tdm.sys matches 4 run scoreboard players set @e[tag=tdm.fresh] tdm.type 7
execute if score #weapon_roll tdm.sys matches 5 run scoreboard players set @e[tag=tdm.fresh] tdm.type 8
execute if score #weapon_roll tdm.sys matches 6 run scoreboard players set @e[tag=tdm.fresh] tdm.type 10
execute as @e[tag=tdm.fresh] if score @s tdm.type matches 2 run item replace entity @s contents with minecraft:trident[minecraft:item_model="oa:pichipichi"]
execute as @e[tag=tdm.fresh] if score @s tdm.type matches 4 run item replace entity @s contents with minecraft:carrot_on_a_stick[minecraft:item_model="oa:nero"]
execute as @e[tag=tdm.fresh] if score @s tdm.type matches 6 run item replace entity @s contents with minecraft:carrot_on_a_stick[minecraft:item_model="oa:yuttari"]
execute as @e[tag=tdm.fresh] if score @s tdm.type matches 7 run item replace entity @s contents with minecraft:carrot_on_a_stick[minecraft:item_model="oa:hotchikisu"]
execute as @e[tag=tdm.fresh] if score @s tdm.type matches 8 run item replace entity @s contents with minecraft:carrot_on_a_stick[minecraft:item_model="oa:komame"]
execute as @e[tag=tdm.fresh] if score @s tdm.type matches 10 run item replace entity @s contents with minecraft:carrot_on_a_stick[minecraft:item_model="oa:itori"]
