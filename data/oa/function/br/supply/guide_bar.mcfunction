function oa:br/supply/guide_calc
execute if score #dist br.tmp matches ..12 run return run title @s actionbar [{text:"✈ 補給物資はすぐ近く！",color:"yellow",bold:true}]
title @s actionbar [{text:"✈ 補給物資 ",color:"gold",bold:true},{storage:"oa:supply",nbt:"arrow",color:"yellow",bold:true},{storage:"oa:supply",nbt:"dir",color:"yellow",bold:true},{text:" 約",color:"white"},{score:{name:"#dist",objective:"br.tmp"},color:"green",bold:true},{text:"m（",color:"white"},{storage:"oa:supply",nbt:"region",interpret:true,color:"aqua"},{text:"）",color:"white"}]
