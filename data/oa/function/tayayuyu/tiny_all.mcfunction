tellraw @a[tag=br.playing] {text:"たやゆゆ変態ガチャ：全員ちび化",color:"green"}
tellraw @a[tag=br.playing] {"text": " → 生存者全員：体の大きさが半分（15秒）", "color": "gray"}
execute as @a[tag=br.alive,gamemode=!spectator,nbt=!{Health:0.0f}] at @s run function oa:tayayuyu/size {amount:-0.5,ticks:300}
