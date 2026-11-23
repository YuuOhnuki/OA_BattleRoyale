# 2026-11-23：会場の削除の進み具合を10区画ごとにチャットへ（全員）
scoreboard players set #ten oa.map2 10
scoreboard players operation #prog oa.map2 = #delete_tile oa.map2
scoreboard players operation #prog oa.map2 %= #ten oa.map2
execute unless score #prog oa.map2 matches 0 run return 0
execute if score #delete_tile oa.map2 matches 100.. run return 0
tellraw @a [{text:"[会場の削除] ",color:"gold"},{nbt:"name",storage:"oa_map2:job",interpret:true,color:"yellow"},{text:"：",color:"gray"},{score:{name:"#delete_tile",objective:"oa.map2"},color:"white"},{text:"/100 区画",color:"gray"}]
