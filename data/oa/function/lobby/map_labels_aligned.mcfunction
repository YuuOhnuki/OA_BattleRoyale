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
summon minecraft:item_display ~0.5 ~5.5 ~34.35 {Tags:["oa.lobby_exhibit","oa.lobby_map","oa.map_panel1116"],billboard:"fixed",Rotation:[0.0f,0.0f],item_display:"none",brightness:{block:15,sky:15},view_range:1.0f,item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"oa:lobby_map_panel"}},transformation:{translation:[0.0f,0.0f,0.0f],left_rotation:[0.0f,0.0f,0.0f,1.0f],scale:[9.0f,9.0f,1.0f],right_rotation:[0.0f,0.0f,0.0f,1.0f]}}
kill @e[type=minecraft:item_display,tag=oa.map_panel1982,distance=..45]
kill @e[type=minecraft:marker,tag=oa.button_mapsel,distance=..45]
kill @e[type=minecraft:text_display,tag=oa.mapsel_text,distance=..45]
# 1.9.231: マップ選択は、マップごとの5つのボタン（パネルの前に立つと左から 地上・ネザー・洞窟・天空都市・異界。東＝+x が左）。
# ボタンの上に名前と状態（lobby/mapsel/labels）。1.9.168〜1.9.230 は「前へ／次へ」の2つだった
fill ~-5 ~0 ~34 ~5 ~0 ~34 minecraft:air
setblock ~4 ~0 ~34 minecraft:stone_button[face=wall,facing=north,powered=false]
summon minecraft:marker ~4.5 ~0.2 ~34.5 {Tags:["oa.lobby_exhibit","oa.button_mapsel","oa.mapsel_k0"]}
summon minecraft:text_display ~4.5 ~0.95 ~34.1 {Tags:["oa.lobby_exhibit","oa.mapsel_text","oa.mapsel_t0"],billboard:"fixed",Rotation:[0.0f,0.0f],text:{text:"…"},background:-1073741824,view_range:0.6f,line_width:80,transformation:{translation:[0.0f,0.0f,0.0f],left_rotation:[0.0f,0.0f,0.0f,1.0f],scale:[0.7f,0.7f,0.7f],right_rotation:[0.0f,0.0f,0.0f,1.0f]}}
setblock ~2 ~0 ~34 minecraft:stone_button[face=wall,facing=north,powered=false]
summon minecraft:marker ~2.5 ~0.2 ~34.5 {Tags:["oa.lobby_exhibit","oa.button_mapsel","oa.mapsel_k1"]}
summon minecraft:text_display ~2.5 ~0.95 ~34.1 {Tags:["oa.lobby_exhibit","oa.mapsel_text","oa.mapsel_t1"],billboard:"fixed",Rotation:[0.0f,0.0f],text:{text:"…"},background:-1073741824,view_range:0.6f,line_width:80,transformation:{translation:[0.0f,0.0f,0.0f],left_rotation:[0.0f,0.0f,0.0f,1.0f],scale:[0.7f,0.7f,0.7f],right_rotation:[0.0f,0.0f,0.0f,1.0f]}}
setblock ~0 ~0 ~34 minecraft:stone_button[face=wall,facing=north,powered=false]
summon minecraft:marker ~0.5 ~0.2 ~34.5 {Tags:["oa.lobby_exhibit","oa.button_mapsel","oa.mapsel_k2"]}
summon minecraft:text_display ~0.5 ~0.95 ~34.1 {Tags:["oa.lobby_exhibit","oa.mapsel_text","oa.mapsel_t2"],billboard:"fixed",Rotation:[0.0f,0.0f],text:{text:"…"},background:-1073741824,view_range:0.6f,line_width:80,transformation:{translation:[0.0f,0.0f,0.0f],left_rotation:[0.0f,0.0f,0.0f,1.0f],scale:[0.7f,0.7f,0.7f],right_rotation:[0.0f,0.0f,0.0f,1.0f]}}
setblock ~-2 ~0 ~34 minecraft:stone_button[face=wall,facing=north,powered=false]
summon minecraft:marker ~-1.5 ~0.2 ~34.5 {Tags:["oa.lobby_exhibit","oa.button_mapsel","oa.mapsel_k3"]}
summon minecraft:text_display ~-1.5 ~0.95 ~34.1 {Tags:["oa.lobby_exhibit","oa.mapsel_text","oa.mapsel_t3"],billboard:"fixed",Rotation:[0.0f,0.0f],text:{text:"…"},background:-1073741824,view_range:0.6f,line_width:80,transformation:{translation:[0.0f,0.0f,0.0f],left_rotation:[0.0f,0.0f,0.0f,1.0f],scale:[0.7f,0.7f,0.7f],right_rotation:[0.0f,0.0f,0.0f,1.0f]}}
setblock ~-4 ~0 ~34 minecraft:stone_button[face=wall,facing=north,powered=false]
summon minecraft:marker ~-3.5 ~0.2 ~34.5 {Tags:["oa.lobby_exhibit","oa.button_mapsel","oa.mapsel_k4"]}
summon minecraft:text_display ~-3.5 ~0.95 ~34.1 {Tags:["oa.lobby_exhibit","oa.mapsel_text","oa.mapsel_t4"],billboard:"fixed",Rotation:[0.0f,0.0f],text:{text:"…"},background:-1073741824,view_range:0.6f,line_width:80,transformation:{translation:[0.0f,0.0f,0.0f],left_rotation:[0.0f,0.0f,0.0f,1.0f],scale:[0.7f,0.7f,0.7f],right_rotation:[0.0f,0.0f,0.0f,1.0f]}}
function oa:lobby/map_panel_update
