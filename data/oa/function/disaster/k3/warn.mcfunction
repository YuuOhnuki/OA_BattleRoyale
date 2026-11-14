# 災害の合図（発生の5秒前に表示。効果は発生時に k3/start で始まる）
title @a[tag=br.playing] times 10 60 15
title @a[tag=br.playing] subtitle {text:"赤い円から離れるか、屋根の下へ！",color:"yellow"}
title @a[tag=br.playing] title {text:"⚠ 災害：隕石群",color:"red",bold:true}
tellraw @a[tag=br.playing] [{text:"⚠ 災害警報：",color:"red",bold:true},{text:"隕石群（24秒）　",color:"white",bold:true},{text:"赤い円の場所に隕石が落ちてくる。円から離れるか、屋根の下へ",color:"gray"}]
