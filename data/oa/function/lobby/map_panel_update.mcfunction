# ロビーの地図パネルと選択ボタンの文字を、選択中のマップに合わせる（ロビー原点の位置で実行）
execute if data storage oa:maps {current:"br"} run data modify entity @e[type=minecraft:item_display,tag=oa.map_panel1116,limit=1,distance=..45] item.components."minecraft:item_model" set value "oa:lobby_map_panel"
execute if data storage oa:maps {current:"nether"} run data modify entity @e[type=minecraft:item_display,tag=oa.map_panel1116,limit=1,distance=..45] item.components."minecraft:item_model" set value "oa:lobby_map_panel_nether"
execute if data storage oa:maps {current:"br"} run data modify entity @e[type=minecraft:text_display,tag=oa.mapsel_t_br,limit=1,distance=..45] text set value {text:"✔ 地上",color:"green",bold:true}
execute unless data storage oa:maps {current:"br"} run data modify entity @e[type=minecraft:text_display,tag=oa.mapsel_t_br,limit=1,distance=..45] text set value {text:"地上",color:"gray"}
execute if data storage oa:maps {current:"nether"} run data modify entity @e[type=minecraft:text_display,tag=oa.mapsel_t_nether,limit=1,distance=..45] text set value {text:"✔ ネザー",color:"green",bold:true}
execute unless data storage oa:maps {current:"nether"} run data modify entity @e[type=minecraft:text_display,tag=oa.mapsel_t_nether,limit=1,distance=..45] text set value {text:"ネザー",color:"gray"}
