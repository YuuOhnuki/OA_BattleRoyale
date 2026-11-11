tellraw @a[tag=br.playing] {text:"たやゆゆ変態ガチャ：丸見え大会",color:"green"}
tellraw @a[tag=br.playing] {"text": " → 生存者全員：発光して位置が見える（10秒）", "color": "gray"}
execute as @a[tag=br.alive,gamemode=!spectator,nbt=!{Health:0.0f}] at @s run function oa:tayayuyu/reveal
