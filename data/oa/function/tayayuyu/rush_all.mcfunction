tellraw @a[tag=br.playing] {text:"たやゆゆ変態ガチャ：爆速",color:"green"}
tellraw @a[tag=br.playing] {"text": " → 生存者全員：移動速度＋150%、止まれない（30秒）", "color": "gray"}
execute as @a[tag=br.alive,gamemode=!spectator,tag=!oa.dead] at @s run function oa:tayayuyu/rush
