# 災害の合図（発生の5秒前に表示。効果は発生時に k2/start で始まる）
title @a[tag=br.playing] times 10 60 15
title @a[tag=br.playing] subtitle {text:"屋根の下か、革の胸当てで耐えよう",color:"yellow"}
title @a[tag=br.playing] title {text:"⚠ 災害：寒波",color:"aqua",bold:true}
tellraw @a[tag=br.playing] [{text:"⚠ 災害警報（5秒後に発生）：",color:"aqua",bold:true},{text:"寒波　",color:"white",bold:true},{text:"空の下は毎秒2ダメージ＋鈍足。屋根か革の胸当てで防げる（30秒）",color:"gray"}]
