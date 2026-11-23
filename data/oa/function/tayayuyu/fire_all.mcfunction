tellraw @a[tag=br.playing] {text:"たやゆゆ変態ガチャ：炎",color:"green"}
tellraw @a[tag=br.playing] {"text": " → 生存者全員が10秒 燃えて光る", "color": "gray"}
execute as @a[tag=br.alive,gamemode=!spectator,tag=!oa.dead] at @s run function oa:tayayuyu/fire
