scoreboard players set #dis_left br.tmp 40
execute as @a[tag=br.alive,sort=random,limit=3] at @s run function oa:disaster/k4/spawn
title @a[tag=br.playing] times 10 60 15
title @a[tag=br.playing] subtitle {text:"緑の霧に入るな！",color:"yellow"}
title @a[tag=br.playing] title {text:"⚠ 災害：毒霧",color:"dark_green",bold:true}
tellraw @a[tag=br.playing] [{text:"⚠ 災害発生：",color:"dark_green",bold:true},{text:"毒霧　",color:"white",bold:true},{text:"緑の霧の中（半径9）は毎秒1ダメージ＋毒。霧は40秒で消える",color:"gray"}]
