scoreboard players set #dis_left br.tmp 10
title @a[tag=br.playing] times 10 60 15
title @a[tag=br.playing] subtitle {text:"足元が揺れる！",color:"yellow"}
title @a[tag=br.playing] title {text:"⚠ 災害：地震",color:"gold",bold:true}
tellraw @a[tag=br.playing] [{text:"⚠ 災害発生：",color:"gold",bold:true},{text:"地震　",color:"white",bold:true},{text:"全員がふらつく。たまに転んで1ダメージ（10秒）",color:"gray"}]
