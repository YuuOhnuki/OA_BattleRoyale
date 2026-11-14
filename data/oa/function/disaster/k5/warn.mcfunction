# 災害の合図（発生の5秒前に表示。効果は発生時に k5/start で始まる）
title @a[tag=br.playing] times 10 60 15
title @a[tag=br.playing] subtitle {text:"動くな！ 止まれ！",color:"yellow"}
title @a[tag=br.playing] title {text:"⚠ 災害：地震",color:"gold",bold:true}
tellraw @a[tag=br.playing] [{text:"⚠ 災害警報：",color:"gold",bold:true},{text:"地震（10秒）　",color:"white",bold:true},{text:"大地が揺れる。動くとダメージを受けるので、止まって耐えよう",color:"gray"}]
