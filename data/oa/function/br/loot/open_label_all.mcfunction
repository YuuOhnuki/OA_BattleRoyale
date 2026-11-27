# 試合会場の開けたチェストの札を、札ごとに書き換える（1.9.255 から再補充のあとも毎秒。中身が空になったら「空」を出すため）
execute if score #map oa.mapid matches 0 in oa:br as @e[distance=0..,type=minecraft:text_display,tag=br.open_label] at @s run function oa:br/loot/open_label_one
execute if score #map oa.mapid matches 1 in oa:br_nether as @e[distance=0..,type=minecraft:text_display,tag=br.open_label] at @s run function oa:br/loot/open_label_one
execute if score #map oa.mapid matches 2 in oa:br_cave as @e[distance=0..,type=minecraft:text_display,tag=br.open_label] at @s run function oa:br/loot/open_label_one
execute if score #map oa.mapid matches 3 in oa:br_sky as @e[distance=0..,type=minecraft:text_display,tag=br.open_label] at @s run function oa:br/loot/open_label_one
execute if score #map oa.mapid matches 4 in oa:br_end as @e[distance=0..,type=minecraft:text_display,tag=br.open_label] at @s run function oa:br/loot/open_label_one
