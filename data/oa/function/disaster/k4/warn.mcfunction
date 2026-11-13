# 災害の合図（発生の5秒前に表示。効果は発生時に k4/start で始まる）
title @a[tag=br.playing] times 10 60 15
title @a[tag=br.playing] subtitle {text:"緑の霧に入るな！",color:"yellow"}
title @a[tag=br.playing] title {text:"⚠ 災害：毒霧",color:"dark_green",bold:true}
tellraw @a[tag=br.playing] [{text:"⚠ 災害警報（5秒後に発生）：",color:"dark_green",bold:true},{text:"毒霧　",color:"white",bold:true},{text:"緑の霧の中（半径9）は毎秒1ダメージ＋毒。霧は40秒で消える",color:"gray"}]
