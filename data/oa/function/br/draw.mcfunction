execute unless score #state br.state matches 1 run return 0
tag @a[tag=br.winner] remove br.winner
tellraw @a[tag=br.playing] {text:"生存者なし：引き分け",color:"yellow"}
title @a[tag=br.playing] times 10 90 20
title @a[tag=br.playing] title {text:"引き分け",color:"yellow"}
function oa:br/result/show
function oa:br/celebration/start
