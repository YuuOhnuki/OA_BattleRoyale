$execute if score #map oa.mapid matches 0 in oa:br store success score @s br.tp_ok run tp @s $(x) $(y) $(z)
$execute if score #map oa.mapid matches 1 in oa:br_nether store success score @s br.tp_ok run tp @s $(x) $(y) $(z)
# 1.9.155: TPした直後にも地表へそろえる（チャンクが未読み込みなら何もせず、tp_fix_all の再確認に任せる）
execute if score @s br.tp_ok matches 1 at @s run function oa:br/tp_fix
