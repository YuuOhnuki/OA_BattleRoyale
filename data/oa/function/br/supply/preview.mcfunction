tag @s remove br.supply_new
tag @s add br.supply_wait
execute store result score @s br.suptype run random value 1..3
execute store result score #mx br.tmp run data get entity @s Pos[0]
execute store result score #mz br.tmp run data get entity @s Pos[2]
function oa:br/supply/region
title @a[tag=br.playing] times 5 70 15
title @a[tag=br.playing] subtitle [{text:"場所：",color:"white"},{storage:"oa:supply",nbt:"region",color:"aqua",bold:true},{text:" ／ 約30秒後に着地",color:"gray"}]
title @a[tag=br.playing] title {text:"✈ 空中補給用意",color:"gold",bold:true}
tellraw @a[tag=br.playing] [{text:"━━ ✈ 空中補給の予告 ━━",color:"gold",bold:true}]
tellraw @a[tag=br.playing] [{text:"約30秒後に空から降ってきます。場所：",color:"yellow"},{storage:"oa:supply",nbt:"region",color:"aqua",bold:true},{text:"（X:",color:"gray"},{score:{name:"#mx",objective:"br.tmp"},color:"white"},{text:" Z:",color:"gray"},{score:{name:"#mz",objective:"br.tmp"},color:"white"},{text:"）",color:"gray"}]
execute as @a[tag=br.playing] at @s run function oa:br/supply/guide_chat
execute if score @s br.suptype matches 1 run tellraw @a[tag=br.playing] {text:"種類：バランス（武器と回復）",color:"aqua"}
execute if score @s br.suptype matches 2 run tellraw @a[tag=br.playing] {text:"種類：回復・食料たっぷり",color:"green"}
execute if score @s br.suptype matches 3 run tellraw @a[tag=br.playing] {text:"種類：武器たっぷり（取り合い注意！）",color:"red"}
execute as @a[tag=br.playing] at @s run playsound minecraft:block.note_block.bell player @s ~ ~ ~ 1.2 1.4
