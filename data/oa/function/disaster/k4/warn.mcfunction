# 災害の合図（発生の5秒前に表示。効果は発生時に k4/start で始まる）
title @a[tag=br.playing] times 10 60 15
title @a[tag=br.playing] subtitle {text:"緑の霧に入るな！",color:"yellow"}
title @a[tag=br.playing] title {text:"⚠ 災害：毒霧",color:"dark_green",bold:true}
tellraw @a[tag=br.playing] [{text:"⚠ 災害警報：",color:"dark_green",bold:true},{text:"毒霧（40秒）　",color:"white",bold:true},{text:"緑の毒の霧が立ちこめる。霧に入らないように",color:"gray"}]
