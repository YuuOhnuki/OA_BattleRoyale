# 災害の合図（発生の5秒前に表示。効果は発生時に k1/start で始まる）
title @a[tag=br.playing] times 10 60 15
title @a[tag=br.playing] subtitle {text:"頭に防具を着けるか、屋根の下へ",color:"yellow"}
title @a[tag=br.playing] title {text:"⚠ 災害：酸性雨",color:"green",bold:true}
tellraw @a[tag=br.playing] [{text:"⚠ 災害警報：",color:"green",bold:true},{text:"酸性雨（30秒）　",color:"white",bold:true},{text:"酸の雨が降る。屋根の下か、頭の防具で防げる",color:"gray"}]
