# 1.9.269：信号弾の補給の中身＝いまの時刻の空中補給と同じグレード・同じ中身（グレードの区切りは br/supply/preview と同じ）
scoreboard players set #sup_grade br.tmp 1
execute if score #time br.time matches 6001..8400 run scoreboard players set #sup_grade br.tmp 2
execute if score #time br.time matches 8401.. run scoreboard players set #sup_grade br.tmp 3
function oa:br/supply/contents
