# 1.9.192: 時限爆弾の1秒（残り秒の表示・時計の音・発光）
scoreboard players operation #oni_sec oa.tmp = #g_oni oa.tmp
scoreboard players operation #oni_sec oa.tmp /= #c20 oa.tmp
effect give @a[tag=oa.g_oni] minecraft:glowing 2 0 true
execute as @a[tag=oa.g_oni] at @s run playsound minecraft:block.note_block.hat player @a[distance=..32] ~ ~ ~ 1.5 1.2
title @a[tag=oa.g_oni] actionbar [{text:"💣 爆弾を持っている！ 残り",color:"red",bold:true},{score:{name:"#oni_sec",objective:"oa.tmp"},color:"gold"},{text:"秒　殴って押しつけろ",color:"red"}]
execute if score #oni_sec oa.tmp matches 30 run tellraw @a[tag=br.playing] [{text:"💣 時限爆弾 残り30秒　鬼：",color:"red"},{selector:"@a[tag=oa.g_oni]",color:"white"}]
execute if score #oni_sec oa.tmp matches 10 run tellraw @a[tag=br.playing] [{text:"💣 時限爆弾 残り10秒　鬼：",color:"red"},{selector:"@a[tag=oa.g_oni]",color:"white"}]
execute if score #oni_sec oa.tmp matches 1..5 run tellraw @a[tag=br.playing] [{text:"💣 ",color:"red"},{score:{name:"#oni_sec",objective:"oa.tmp"},color:"gold",bold:true}]
execute if score #oni_sec oa.tmp matches 1..5 as @a[tag=br.playing] at @s run playsound minecraft:block.note_block.pling master @s ~ ~ ~ 1 1.5
