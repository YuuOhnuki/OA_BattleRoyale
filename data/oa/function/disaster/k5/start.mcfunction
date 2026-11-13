scoreboard players set #dis_left br.tmp 10
title @a[tag=br.playing] times 10 60 15
title @a[tag=br.playing] subtitle {text:"動くな！ 止まれ！",color:"yellow"}
title @a[tag=br.playing] title {text:"⚠ 災害：地震",color:"gold",bold:true}
tellraw @a[tag=br.playing] [{text:"⚠ 災害発生：",color:"gold",bold:true},{text:"地震　",color:"white",bold:true},{text:"全員がふらつく。動くと毎秒3ダメージ。止まって耐えよう（10秒）",color:"gray"}]
scoreboard players set @a[tag=br.playing] br.qwalk 0
scoreboard players set @a[tag=br.playing] br.qspr 0
scoreboard players set @a[tag=br.playing] br.qsneak 0
scoreboard players set @a[tag=br.playing] br.qjump 0
