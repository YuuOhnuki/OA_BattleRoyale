tellraw @a[tag=br.playing] {text:"たやゆゆ変態ガチャ：炎",color:"#12a88f"}
tellraw @a[tag=br.playing] {"text": " → 生存者全員が10秒 燃えて光る", "color": "gray"}
execute as @a[tag=br.alive,gamemode=!spectator,tag=!oa.dead] at @s run function oa:tayayuyu/fire
