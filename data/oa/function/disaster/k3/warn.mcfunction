# 災害の合図（発生の5秒前に表示。効果は発生時に k3/start で始まる）
title @a[tag=br.playing] times 10 60 15
title @a[tag=br.playing] subtitle {text:"赤い円から離れるか、屋根の下へ！",color:"yellow"}
title @a[tag=br.playing] title {text:"⚠ 災害：隕石群",color:"red",bold:true}
tellraw @a[tag=br.playing] [{text:"⚠ 災害警報（5秒後に発生）：",color:"red",bold:true},{text:"隕石群　",color:"white",bold:true},{text:"赤い円は3秒後に着弾。中心近く（半径3.5）は12ダメージ、外側（5.5）は6ダメージ。屋根の下なら当たらない。地形は壊れない（24秒）",color:"gray"}]
