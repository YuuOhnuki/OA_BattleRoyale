kill @e[type=minecraft:item_frame,tag=oa.map_native1981,distance=..45]
kill @e[type=minecraft:item_frame,tag=oa.map_native1980,distance=..45]
kill @e[tag=oa.map_image1979,distance=..45]
execute positioned ~0 ~5 ~30 run kill @e[type=minecraft:text_display,tag=oa.lobby_label,distance=..0.2]
kill @e[type=minecraft:marker,tag=oa.map_mural1969,distance=..45]
kill @e[type=minecraft:marker,tag=oa.map_image1974,distance=..45]
kill @e[tag=oa.map_image1976,distance=..45]
kill @e[type=minecraft:text_display,tag=oa.lobby_region1914,distance=..60]
kill @e[type=minecraft:text_display,tag=oa.lobby_region1916,distance=..60]
kill @e[type=minecraft:item_frame,tag=oa.map_flag1925,distance=..60]
kill @e[type=minecraft:item_display,tag=oa.lobby_map,distance=..60]
kill @e[tag=oa.map_legend1969,distance=..60]
execute positioned ~0.5 ~6.2 ~34 run kill @e[type=minecraft:text_display,tag=oa.lobby_label,distance=..0.3]
execute positioned ~0.5 ~0.4 ~33 run kill @e[type=minecraft:text_display,tag=oa.lobby_label,distance=..0.3]
fill ~-5 ~0 ~36 ~5 ~10 ~36 minecraft:polished_blackstone_bricks
fill ~-5 ~0 ~35 ~5 ~10 ~35 minecraft:polished_blackstone_bricks
summon minecraft:item_display ~0.5 ~5.5 ~34.35 {Tags:["oa.lobby_exhibit","oa.lobby_map","oa.map_panel1982"],billboard:"fixed",Rotation:[0.0f,0.0f],item_display:"none",brightness:{block:15,sky:15},view_range:1.0f,item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"oa:lobby_map_panel"}},transformation:{translation:[0.0f,0.0f,0.0f],left_rotation:[0.0f,0.0f,0.0f,1.0f],scale:[9.0f,9.0f,1.0f],right_rotation:[0.0f,0.0f,0.0f,1.0f]}}
