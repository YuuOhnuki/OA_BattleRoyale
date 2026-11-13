scoreboard players set #dis_left br.tmp 30
title @a[tag=br.playing] times 10 60 15
title @a[tag=br.playing] subtitle {text:"屋根の下か、革の胸当てで耐えよう",color:"yellow"}
title @a[tag=br.playing] title {text:"⚠ 災害：寒波",color:"aqua",bold:true}
tellraw @a[tag=br.playing] [{text:"⚠ 災害発生：",color:"aqua",bold:true},{text:"寒波　",color:"white",bold:true},{text:"空の下は凍える。屋根か革の胸当てで防げる（30秒）",color:"gray"}]
