tellraw @a[tag=br.playing] {text:"たやゆゆ変態ガチャ：炎",color:"green"}
tellraw @a[tag=br.playing] [{"text": " → 生存者全員：10秒間、毎秒","color":"gray"},{"text":"\ue100","color":"red","font":"oa:icons"},{"text":"×1の炎ダメージ・発光10秒","color":"gray"}]
execute as @a[tag=br.alive,gamemode=!spectator,tag=!oa.dead] at @s run function oa:tayayuyu/fire
