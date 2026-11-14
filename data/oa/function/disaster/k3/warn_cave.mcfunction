# 1.9.167: 洞窟の落盤の合図（発生の5秒前に表示。効果は k3/start、着弾は k3/impact）
title @a[tag=br.playing] times 10 60 15
title @a[tag=br.playing] subtitle {text:"赤い円から離れろ！",color:"yellow"}
title @a[tag=br.playing] title {text:"⚠ 災害：落盤",color:"red",bold:true}
tellraw @a[tag=br.playing] [{text:"⚠ 災害警報：",color:"red",bold:true},{text:"落盤（24秒）　",color:"white",bold:true},{text:"赤い円の場所に天井の岩が落ちてくる。円から離れよう",color:"gray"}]
