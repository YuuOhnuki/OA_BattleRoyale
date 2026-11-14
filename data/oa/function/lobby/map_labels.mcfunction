$execute in minecraft:overworld positioned $(x) $(y) $(z) if loaded ~-5 ~0 ~35 if loaded ~5 ~0 ~35 unless entity @e[type=minecraft:item_display,tag=oa.map_panel1116,distance=..45] run function oa:lobby/map_labels_build
# 1.9.167: 洞窟のボタンがなければ作り直す（ロビーの再建築をしなくても3つ目のボタンが出る）
$execute in minecraft:overworld positioned $(x) $(y) $(z) if loaded ~-5 ~0 ~35 if loaded ~5 ~0 ~35 if entity @e[type=minecraft:item_display,tag=oa.map_panel1116,distance=..45] unless entity @e[type=minecraft:marker,tag=oa.mapsel_cave,distance=..45] run function oa:lobby/map_labels_build
$execute in minecraft:overworld positioned $(x) $(y) $(z) if loaded ~0 ~0 ~34 run function oa:lobby/map_panel_update
