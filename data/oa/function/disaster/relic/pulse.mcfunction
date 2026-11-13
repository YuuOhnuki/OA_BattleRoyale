# 解錠中は1秒ごとに光の柱と鐘の音で、遠くからも場所が分かる
particle minecraft:end_rod ~ ~1.5 ~ 0.1 14 0.1 0.01 50 force @a[distance=..96]
playsound minecraft:block.note_block.bell block @a[distance=..48] ~ ~ ~ 1.5 1.6
scoreboard players operation #rl_s br.tmp = @s br.dtmr
scoreboard players operation #rl_s br.tmp /= #20 br.tmp
scoreboard players add #rl_s br.tmp 1
title @a[tag=br.alive,distance=..5] times 0 30 5
title @a[tag=br.alive,distance=..5] title {text:" "}
title @a[tag=br.alive,distance=..5] subtitle [{text:"✦ 解錠まで あと ",color:"light_purple"},{score:{name:"#rl_s",objective:"br.tmp"},color:"white"},{text:" 秒",color:"light_purple"}]
