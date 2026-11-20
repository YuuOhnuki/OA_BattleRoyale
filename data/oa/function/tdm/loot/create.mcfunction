summon minecraft:item_display ~ ~0.5 ~ {Tags:["tdm.pickup","tdm.fresh"],billboard:"center",Glowing:1b,view_range:0.8f}
scoreboard players operation @e[tag=tdm.fresh] tdm.type = #drop_kind tdm.sys
scoreboard players set @e[tag=tdm.fresh] tdm.cool 800
execute if score #drop_kind tdm.sys matches 1 run item replace entity @e[tag=tdm.fresh,limit=1] contents with minecraft:carrot_on_a_stick[minecraft:item_model="oa:yuua"]
execute if score #drop_kind tdm.sys matches 2 run item replace entity @e[tag=tdm.fresh,limit=1] contents with minecraft:carrot_on_a_stick[minecraft:item_model="oa:pichipichi"]
execute if score #drop_kind tdm.sys matches 3 run item replace entity @e[tag=tdm.fresh,limit=1] contents with minecraft:carrot_on_a_stick[minecraft:item_model="oa:raji"]
execute if score #drop_kind tdm.sys matches 4 run item replace entity @e[tag=tdm.fresh,limit=1] contents with minecraft:carrot_on_a_stick[minecraft:item_model="oa:nero"]
execute if score #drop_kind tdm.sys matches 5 run item replace entity @e[tag=tdm.fresh,limit=1] contents with minecraft:carrot_on_a_stick[minecraft:item_model="oa:killing"]
execute if score #drop_kind tdm.sys matches 6 run item replace entity @e[tag=tdm.fresh,limit=1] contents with minecraft:carrot_on_a_stick[minecraft:item_model="oa:yuttari"]
execute if score #drop_kind tdm.sys matches 7 run item replace entity @e[tag=tdm.fresh,limit=1] contents with minecraft:carrot_on_a_stick[minecraft:item_model="oa:hotchikisu"]
execute if score #drop_kind tdm.sys matches 8 run item replace entity @e[tag=tdm.fresh,limit=1] contents with minecraft:carrot_on_a_stick[minecraft:item_model="oa:komame"]
execute if score #drop_kind tdm.sys matches 10 run item replace entity @e[tag=tdm.fresh,limit=1] contents with minecraft:carrot_on_a_stick[minecraft:item_model="oa:itori"]
execute if score #drop_kind tdm.sys matches 101 run item replace entity @e[tag=tdm.fresh,limit=1] contents with minecraft:iron_chestplate
execute if score #drop_kind tdm.sys matches 102 run item replace entity @e[tag=tdm.fresh,limit=1] contents with minecraft:diamond_chestplate
execute if score #drop_kind tdm.sys matches 103 run item replace entity @e[tag=tdm.fresh,limit=1] contents with minecraft:totem_of_undying[minecraft:item_model="oa:yu"]
tag @e[tag=tdm.fresh] remove tdm.fresh
particle minecraft:happy_villager ~ ~1 ~ 0.3 0.3 0.3 0 8 normal @a[distance=..32]
