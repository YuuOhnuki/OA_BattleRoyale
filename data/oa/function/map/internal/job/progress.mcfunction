# 2026-11-23：会場の生成の進み具合を10区画ごとにチャットへ（全員）。job/next から（同じ区画で二度は出さない）
scoreboard players set #ten oa.map2 10
scoreboard players operation #prog oa.map2 = #tile oa.map2
scoreboard players operation #prog oa.map2 %= #ten oa.map2
execute unless score #prog oa.map2 matches 0 run return 0
execute if score #tile oa.map2 matches 0 run return 0
execute if score #prog_last oa.map2 = #tile oa.map2 run return 0
scoreboard players operation #prog_last oa.map2 = #tile oa.map2
execute unless score #mode oa.map2 matches 2 run tellraw @a [{text:"[会場の生成] ",color:"gold"},{nbt:"name",storage:"oa_map2:job",interpret:true,color:"yellow"},{text:"：地形と登録 ",color:"gray"},{score:{name:"#tile",objective:"oa.map2"},color:"white"},{text:"/100 区画",color:"gray"}]
execute if score #mode oa.map2 matches 2 run tellraw @a [{text:"[会場の生成] ",color:"gold"},{nbt:"name",storage:"oa_map2:job",interpret:true,color:"yellow"},{text:"：仕上げ ",color:"gray"},{score:{name:"#tile",objective:"oa.map2"},color:"white"},{text:"/100 区画",color:"gray"}]
