# ロビーの地図パネルと選択ボタンの文字を、選択中のマップに合わせる（ロビー原点の位置で実行）
execute if data storage oa:maps {current:"br"} run data modify entity @e[tag=!oa.holo_custom,type=minecraft:item_display,tag=oa.map_panel1116,limit=1,distance=..45] item.components."minecraft:item_model" set value "oa:lobby_map_panel"
execute if data storage oa:maps {current:"nether"} run data modify entity @e[tag=!oa.holo_custom,type=minecraft:item_display,tag=oa.map_panel1116,limit=1,distance=..45] item.components."minecraft:item_model" set value "oa:lobby_map_panel_nether"
execute if data storage oa:maps {current:"cave"} run data modify entity @e[tag=!oa.holo_custom,type=minecraft:item_display,tag=oa.map_panel1116,limit=1,distance=..45] item.components."minecraft:item_model" set value "oa:lobby_map_panel_cave"
execute if data storage oa:maps {current:"br"} run data modify entity @e[tag=!oa.holo_custom,type=minecraft:text_display,tag=oa.mapsel_t_cur,limit=1,distance=..45] text set value {text:"地上",color:"gold",bold:true}
execute if data storage oa:maps {current:"nether"} run data modify entity @e[tag=!oa.holo_custom,type=minecraft:text_display,tag=oa.mapsel_t_cur,limit=1,distance=..45] text set value {text:"ネザー",color:"gold",bold:true}
execute if data storage oa:maps {current:"cave"} run data modify entity @e[tag=!oa.holo_custom,type=minecraft:text_display,tag=oa.mapsel_t_cur,limit=1,distance=..45] text set value {text:"洞窟",color:"gold",bold:true}
execute if data storage oa:maps {current:"sky"} run data modify entity @e[tag=!oa.holo_custom,type=minecraft:item_display,tag=oa.map_panel1116,limit=1,distance=..45] item.components."minecraft:item_model" set value "minecraft:filled_map"
execute if data storage oa:maps {current:"end"} run data modify entity @e[tag=!oa.holo_custom,type=minecraft:item_display,tag=oa.map_panel1116,limit=1,distance=..45] item.components."minecraft:item_model" set value "minecraft:filled_map"
execute if data storage oa:maps {current:"sky"} run data modify entity @e[tag=!oa.holo_custom,type=minecraft:text_display,tag=oa.mapsel_t_cur,limit=1,distance=..45] text set value {text:"天空都市",color:"gold",bold:true}
execute if data storage oa:maps {current:"end"} run data modify entity @e[tag=!oa.holo_custom,type=minecraft:text_display,tag=oa.mapsel_t_cur,limit=1,distance=..45] text set value {text:"異界",color:"gold",bold:true}
function oa:lobby/mapsel/labels
