tellraw @a[tag=br.playing] {text:"たやゆゆ変態ガチャ：体力",color:"green"}
tellraw @a[tag=br.playing] {"text": " → 生存者全員：最大体力＋10ハート・移動速度上昇II・再生I・跳躍力上昇II（45秒）、10ハート回復", "color": "gray"}
execute as @a[tag=br.alive,gamemode=!spectator,nbt=!{Health:0.0f}] at @s run function oa:tayayuyu/health
