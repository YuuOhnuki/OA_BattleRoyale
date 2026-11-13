# 災害の合図（発生の5秒前に表示。効果は発生時に k1/start で始まる）
title @a[tag=br.playing] times 10 60 15
title @a[tag=br.playing] subtitle {text:"頭に防具を着けるか、屋根の下へ",color:"yellow"}
title @a[tag=br.playing] title {text:"⚠ 災害：酸性雨",color:"green",bold:true}
tellraw @a[tag=br.playing] [{text:"⚠ 災害警報（5秒後に発生）：",color:"green",bold:true},{text:"酸性雨　",color:"white",bold:true},{text:"空の見える所で雨に当たると毎秒2ダメージ。頭防具か屋根で防げる（30秒）",color:"gray"}]
