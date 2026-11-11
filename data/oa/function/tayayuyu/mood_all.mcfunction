tellraw @a[tag=br.playing] {text:"たやゆゆ変態ガチャ：全員キリング気分",color:"green"}
tellraw @a[tag=br.playing] {"text": " → 生存者全員：盲目・移動速度＋100%（5秒）", "color": "gray"}
execute as @a[tag=br.alive,gamemode=!spectator,nbt=!{Health:0.0f}] at @s run function oa:tayayuyu/mood
