# 開始TP後に少し浮いていたら、真下の最初の地表へ移す（tp_fix から。位置：調べる高さ、y はブロック単位）
function oa:br/spawn_points/check
execute if score #spawn_floor br.flag matches 1 run return run tp @s ~ ~ ~
scoreboard players remove #tpfix_n br.tmp 1
execute if score #tpfix_n br.tmp matches ..0 run return 0
execute unless block ~ ~ ~ #oa:spawn_clear run return 0
execute unless loaded ~ ~-1 ~ run return 0
execute positioned ~ ~-1 ~ run function oa:br/tp_fix_down
