# 歩き＋走りの合計（cm）。お題5＝500m、お題11＝1000m
scoreboard players operation #mv br.tmp = @s br.st_walk
scoreboard players operation #mv br.tmp += @s br.st_sprint
execute if score #mission br.tmp matches 5 if score #mv br.tmp matches 50000.. run function oa:br/mission/clear
execute if score #mission br.tmp matches 11 if score #mv br.tmp matches 100000.. run function oa:br/mission/clear
