tellraw @a[tag=br.playing] {text:"たやゆゆ変態ガチャ：爆速",color:"green"}
tellraw @a[tag=br.playing] {"text": " → 生存者全員が30秒 爆速・止まれない", "color": "gray"}
execute as @a[tag=br.alive,gamemode=!spectator,tag=!oa.dead] at @s run function oa:tayayuyu/rush
