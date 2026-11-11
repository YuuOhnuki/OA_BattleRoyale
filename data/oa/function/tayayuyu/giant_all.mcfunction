tellraw @a[tag=br.playing] {text:"たやゆゆ変態ガチャ：全員巨大化",color:"green"}
tellraw @a[tag=br.playing] {"text": " → 生存者全員：体の大きさが2.5倍（10秒）", "color": "gray"}
execute as @a[tag=br.alive,gamemode=!spectator,nbt=!{Health:0.0f}] at @s run function oa:tayayuyu/size {amount:1.5,ticks:200}
