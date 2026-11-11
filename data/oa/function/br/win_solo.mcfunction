execute unless score #state br.state matches 1 run return 0
tag @a[tag=br.winner] remove br.winner
tag @a[tag=br.alive,nbt=!{Health:0.0f}] add br.winner
tellraw @a[tag=br.playing] [{text:"★ 優勝：",color:"gold",bold:true},{selector:"@a[tag=br.winner]"}]
title @a[tag=br.playing] times 10 90 20
title @a[tag=br.playing] subtitle [{text:"WINNER：",color:"yellow"},{selector:"@a[tag=br.winner]"}]
title @a[tag=br.playing] title {text:"優勝！",color:"gold",bold:true}
function oa:br/celebration/start
