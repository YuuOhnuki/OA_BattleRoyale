# 災害の合図（発生の5秒前に表示。効果は発生時に k4/start で始まる）
title @a[tag=br.playing] times 10 60 15
title @a[tag=br.playing] subtitle {text:"中心から毒の霧が広がる！",color:"yellow"}
title @a[tag=br.playing] title {text:"⚠ 災害：毒霧",color:"dark_green",bold:true}
tellraw @a[tag=br.playing] [{text:"⚠ 災害警報：",color:"dark_green",bold:true},{text:"毒霧（40秒）　",color:"white",bold:true},{text:"マップの中心から緑の毒の霧が広がる（5秒ごとに5ブロック、最大で半径30）。中心から離れよう",color:"gray"}]
