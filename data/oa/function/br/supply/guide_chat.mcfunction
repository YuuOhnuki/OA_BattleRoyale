function oa:br/supply/guide_calc
execute if score #dist br.tmp matches ..12 run return run tellraw @s [{text:"[補給物資] ",color:"gold",bold:true},{text:"すぐ近くです！",color:"yellow"}]
tellraw @s [{text:"[補給物資] ",color:"gold",bold:true},{text:"あなたから ",color:"white"},{storage:"oa:supply",nbt:"arrow",color:"yellow",bold:true},{storage:"oa:supply",nbt:"dir",color:"yellow",bold:true},{text:" へ約 ",color:"white"},{score:{name:"#dist",objective:"br.tmp"},color:"green",bold:true},{text:"m ／ 場所：",color:"white"},{storage:"oa:supply",nbt:"region",interpret:true,color:"aqua"}]
