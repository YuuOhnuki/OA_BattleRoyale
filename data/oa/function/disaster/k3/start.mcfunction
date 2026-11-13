scoreboard players set #dis_left br.tmp 24
title @a[tag=br.playing] times 10 60 15
title @a[tag=br.playing] subtitle {text:"赤い円から離れろ！",color:"yellow"}
title @a[tag=br.playing] title {text:"⚠ 災害：隕石群",color:"red",bold:true}
tellraw @a[tag=br.playing] [{text:"⚠ 災害発生：",color:"red",bold:true},{text:"隕石群　",color:"white",bold:true},{text:"赤い円が出たら3秒後に落ちる。建物や地形は壊れない（24秒）",color:"gray"}]
