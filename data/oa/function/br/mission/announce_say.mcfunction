$execute if score #mission_hard br.tmp matches 0 run tellraw @a[tag=br.playing] [{text:" ★ 今回のお題  ",color:"gold",bold:true},{text:"$(name)",color:"yellow"}]
$execute if score #mission_hard br.tmp matches 1 run tellraw @a[tag=br.playing] [{text:" ★ 今回のお題  ",color:"gold",bold:true},{text:"$(name)",color:"yellow"},{text:" ［難］",color:"red",bold:true}]
execute if score #mission_hard br.tmp matches 0 run tellraw @a[tag=br.playing] [{text:"    達成で ",color:"gray"},{text:"応急キット",color:"green"}]
execute if score #mission_hard br.tmp matches 1 run tellraw @a[tag=br.playing] [{text:"    達成で ",color:"gray"},{text:"応急キット",color:"green"},{text:"＋",color:"gray"},{"text":"ゆー：オーバーワーク","color":"#55C985","italic":false,"bold":true}]
