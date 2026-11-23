function oa:br/supply/guide_calc
execute if score #dist br.tmp matches ..12 run return run tellraw @s [{text:"    ",color:"gray"},{text:"すぐ近く！",color:"yellow"}]
tellraw @s [{text:"    あなたから ",color:"gray"},{storage:"oa:supply",nbt:"arrow",interpret:true,color:"yellow",bold:true},{storage:"oa:supply",nbt:"dir",interpret:true,color:"yellow",bold:true},{text:" ",color:"gray"},{score:{name:"#dist",objective:"br.tmp"},color:"green",bold:true},{text:"m",color:"gray"}]
