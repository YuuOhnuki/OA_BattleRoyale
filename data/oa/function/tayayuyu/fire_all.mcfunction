tellraw @a[tag=br.playing] {text:"たやゆゆ変態ガチャ：炎",color:"green"}
tellraw @a[tag=br.playing] {"text": " → 生存者全員：8秒間、炎の継続ダメージ", "color": "gray"}
execute as @a[tag=br.alive,gamemode=!spectator,nbt=!{Health:0.0f}] at @s run function oa:tayayuyu/fire
