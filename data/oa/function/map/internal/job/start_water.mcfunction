scoreboard players set #mode oa.map2 2
scoreboard players set #tile oa.map2 0
data modify storage oa_map2:args tile set value 0
scoreboard players set #prog_last oa.map2 -1
tellraw @a [{text:"[会場の生成] ",color:"gold"},{nbt:"name",storage:"oa_map2:job",interpret:true,color:"yellow"},{text:"：地形と登録が完了。最後に仕上げ（水など）をします",color:"aqua"}]
schedule function oa:map/internal/job/next 1t replace
