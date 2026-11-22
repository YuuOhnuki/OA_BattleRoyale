# 歩き＋走りの合計（cm）が 1000m 以上
scoreboard players operation #mv br.tmp = @s br.st_walk
scoreboard players operation #mv br.tmp += @s br.st_sprint
execute if score #mv br.tmp matches 100000.. run function oa:br/mission/clear
