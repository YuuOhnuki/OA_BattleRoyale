# 試合会場の札（特別チェスト以外）を storage oa:br open_label に書き換える。再補充のあとは、最初の2秒だけ（「開封済み」に戻す）
execute if score #time br.time matches 7240.. run return 0
execute if score #map oa.mapid matches 0 in oa:br as @e[distance=0..,type=minecraft:text_display,tag=br.open_label,tag=!br.open_rich] run data modify entity @s text set from storage oa:br open_label
execute if score #map oa.mapid matches 1 in oa:br_nether as @e[distance=0..,type=minecraft:text_display,tag=br.open_label,tag=!br.open_rich] run data modify entity @s text set from storage oa:br open_label
