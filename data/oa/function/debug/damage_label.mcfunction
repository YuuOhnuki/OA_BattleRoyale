$summon minecraft:text_display ~ ~2.1 ~ {Tags:["oa.debug_damage_label","oa.db_label_new"],text:{text:"$(amount) HP",color:"yellow",bold:1b},billboard:"center",view_range:0.5f,background:0,shadow:1b,see_through:1b}
scoreboard players operation @e[type=minecraft:text_display,tag=oa.db_label_new,distance=0..] oa.owner = @s oa.id
scoreboard players set @e[type=minecraft:text_display,tag=oa.db_label_new] oa.db_label 60
tag @e[type=minecraft:text_display,tag=oa.db_label_new] remove oa.db_label_new
