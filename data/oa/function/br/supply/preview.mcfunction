tag @s remove br.supply_new
tag @s add br.supply_wait
# 1.9.142: 補給は回を追うごとに中身が良くなる。1.9.161 から予告は tick 3900・6300・8700（縮小と重ならない時刻）
scoreboard players set @s br.suptype 1
execute if score #time br.time matches 6001..8400 run scoreboard players set @s br.suptype 2
execute if score #time br.time matches 8401.. run scoreboard players set @s br.suptype 3
execute store result score #mx br.tmp run data get entity @s Pos[0]
execute store result score #mz br.tmp run data get entity @s Pos[2]
function oa:br/supply/region
title @a[tag=br.playing] times 5 70 15
title @a[tag=br.playing] subtitle [{text:"場所：",color:"white"},{storage:"oa:supply",nbt:"region",interpret:true,color:"aqua",bold:true},{text:" ／ 約30秒後に着地",color:"gray"}]
title @a[tag=br.playing] title {text:"✈ 空中補給用意",color:"gold",bold:true}
tellraw @a[tag=br.playing] [{text:"━━ ✈ 空中補給の予告 ━━",color:"gold",bold:true}]
tellraw @a[tag=br.playing] [{text:"約30秒後に空から降ってきます。場所：",color:"yellow"},{storage:"oa:supply",nbt:"region",interpret:true,color:"aqua",bold:true},{text:"（X:",color:"gray"},{score:{name:"#mx",objective:"br.tmp"},color:"white"},{text:" Z:",color:"gray"},{score:{name:"#mz",objective:"br.tmp"},color:"white"},{text:"）",color:"gray"}]
execute as @a[tag=br.playing] at @s run function oa:br/supply/guide_chat
# 1.9.157: 便と強さ（★）だけを表示する
execute if score @s br.suptype matches 1 run tellraw @a[tag=br.playing] [{text:"第1便 ",color:"aqua",bold:true},{text:"★",color:"gold"},{text:"☆☆",color:"dark_gray"}]
execute if score @s br.suptype matches 2 run tellraw @a[tag=br.playing] [{text:"第2便 ",color:"aqua",bold:true},{text:"★★",color:"gold"},{text:"☆",color:"dark_gray"}]
execute if score @s br.suptype matches 3 run tellraw @a[tag=br.playing] [{text:"第3便 ",color:"aqua",bold:true},{text:"★★★",color:"gold"}]
execute as @a[tag=br.playing] at @s run playsound minecraft:block.note_block.bell player @s ~ ~ ~ 1.2 1.4
