# 1.9.186: チェストの横に補給を置く（br/supply/cave_chest から）
$execute at @s run tp @s ~$(dx) ~ ~$(dz)
scoreboard players set #sup_good br.tmp 1
