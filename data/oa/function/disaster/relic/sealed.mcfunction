# 右クリックされたら解錠を始める（5秒）。近くに生存者がいなければ無視する
execute unless data entity @s interaction run return 0
data remove entity @s interaction
execute unless entity @a[tag=br.alive,distance=..6] run return 0
scoreboard players set @s br.gkind 2
scoreboard players set @s br.dtmr 100
playsound minecraft:block.beacon.activate block @a[distance=..48] ~ ~ ~ 1.2 1.4
title @a[tag=br.alive,distance=..6] times 0 30 5
title @a[tag=br.alive,distance=..6] title {text:" "}
title @a[tag=br.alive,distance=..6] subtitle {text:"✦ 封印の宝珠を解錠中… 離れると中断",color:"light_purple"}
