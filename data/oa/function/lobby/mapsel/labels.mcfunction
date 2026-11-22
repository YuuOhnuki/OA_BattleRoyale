# 1.9.169: ボタンの上の文字に、押すと切り替わる先のマップ名を出す（lobby/map_panel_update から、ロビー原点の位置で）
scoreboard players set #ms_dir oa.tmp -1
function oa:lobby/mapsel/peek
execute if score #mp oa.tmp matches 0 run data modify entity @e[tag=!oa.holo_custom,type=minecraft:text_display,tag=oa.mapsel_t_prev,limit=1,distance=..45] text set value [{text:"前のマップ\n",color:"gray"},{text:"地上",color:"aqua",bold:true}]
execute if score #mp oa.tmp matches 1 run data modify entity @e[tag=!oa.holo_custom,type=minecraft:text_display,tag=oa.mapsel_t_prev,limit=1,distance=..45] text set value [{text:"前のマップ\n",color:"gray"},{text:"ネザー",color:"aqua",bold:true}]
execute if score #mp oa.tmp matches 2 run data modify entity @e[tag=!oa.holo_custom,type=minecraft:text_display,tag=oa.mapsel_t_prev,limit=1,distance=..45] text set value [{text:"前のマップ\n",color:"gray"},{text:"洞窟",color:"aqua",bold:true}]
execute if score #mp oa.tmp matches 3 run data modify entity @e[tag=!oa.holo_custom,type=minecraft:text_display,tag=oa.mapsel_t_prev,limit=1,distance=..45] text set value [{text:"前のマップ\n",color:"gray"},{text:"天空都市",color:"aqua",bold:true}]
execute if score #mp oa.tmp matches 4 run data modify entity @e[tag=!oa.holo_custom,type=minecraft:text_display,tag=oa.mapsel_t_prev,limit=1,distance=..45] text set value [{text:"前のマップ\n",color:"gray"},{text:"異界",color:"aqua",bold:true}]
execute if score #mp oa.tmp matches -1 run data modify entity @e[tag=!oa.holo_custom,type=minecraft:text_display,tag=oa.mapsel_t_prev,limit=1,distance=..45] text set value [{text:"前のマップ\n",color:"gray"},{text:"（なし）",color:"dark_gray"}]
scoreboard players set #ms_dir oa.tmp 1
function oa:lobby/mapsel/peek
execute if score #mp oa.tmp matches 0 run data modify entity @e[tag=!oa.holo_custom,type=minecraft:text_display,tag=oa.mapsel_t_next,limit=1,distance=..45] text set value [{text:"次のマップ\n",color:"gray"},{text:"地上",color:"aqua",bold:true}]
execute if score #mp oa.tmp matches 1 run data modify entity @e[tag=!oa.holo_custom,type=minecraft:text_display,tag=oa.mapsel_t_next,limit=1,distance=..45] text set value [{text:"次のマップ\n",color:"gray"},{text:"ネザー",color:"aqua",bold:true}]
execute if score #mp oa.tmp matches 2 run data modify entity @e[tag=!oa.holo_custom,type=minecraft:text_display,tag=oa.mapsel_t_next,limit=1,distance=..45] text set value [{text:"次のマップ\n",color:"gray"},{text:"洞窟",color:"aqua",bold:true}]
execute if score #mp oa.tmp matches 3 run data modify entity @e[tag=!oa.holo_custom,type=minecraft:text_display,tag=oa.mapsel_t_next,limit=1,distance=..45] text set value [{text:"次のマップ\n",color:"gray"},{text:"天空都市",color:"aqua",bold:true}]
execute if score #mp oa.tmp matches 4 run data modify entity @e[tag=!oa.holo_custom,type=minecraft:text_display,tag=oa.mapsel_t_next,limit=1,distance=..45] text set value [{text:"次のマップ\n",color:"gray"},{text:"異界",color:"aqua",bold:true}]
execute if score #mp oa.tmp matches -1 run data modify entity @e[tag=!oa.holo_custom,type=minecraft:text_display,tag=oa.mapsel_t_next,limit=1,distance=..45] text set value [{text:"次のマップ\n",color:"gray"},{text:"（なし）",color:"dark_gray"}]
