$execute in minecraft:overworld positioned $(x) $(y) $(z) if loaded ~-5 ~0 ~35 if loaded ~5 ~0 ~35 unless entity @e[type=minecraft:item_display,tag=oa.map_panel1116,distance=..45] run function oa:lobby/map_labels_build
# 1.9.167〜: 今の形のボタン（1.9.168 は前へ／次へ）がなければ作り直す（ロビーの再建築をしなくても新しいボタンになる）
$execute in minecraft:overworld positioned $(x) $(y) $(z) if loaded ~-5 ~0 ~35 if loaded ~5 ~0 ~35 if entity @e[type=minecraft:item_display,tag=oa.map_panel1116,distance=..45] unless entity @e[type=minecraft:marker,tag=oa.mapsel_next,distance=..45] run function oa:lobby/map_labels_build
$execute in minecraft:overworld positioned $(x) $(y) $(z) if loaded ~0 ~0 ~34 run function oa:lobby/map_panel_update
