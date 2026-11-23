tellraw @a[tag=br.playing] {text:"たやゆゆ変態ガチャ：全員キリング気分",color:"#12a88f"}
tellraw @a[tag=br.playing] {"text": " → 生存者全員が10秒 盲目・速くなる", "color": "gray"}
execute as @a[tag=br.alive,gamemode=!spectator,tag=!oa.dead] at @s run function oa:tayayuyu/mood
