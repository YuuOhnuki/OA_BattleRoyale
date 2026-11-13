# 補給物資の方向へ向けたマーカーの向きを読む準備（マクロ）。呼び出し元：guide_calc（プレイヤーの位置）
$execute as @e[type=minecraft:marker,tag=br.sup_arrow,distance=..1,limit=1] at @s run tp @s ~ ~ ~ facing $(x) ~ $(z)
