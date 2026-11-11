tellraw @a[tag=br.playing] {text:"たやゆゆ変態ガチャ：空腹の時間",color:"green"}
tellraw @a[tag=br.playing] {"text": " → 生存者全員：空腹IV（20秒）", "color": "gray"}
execute as @a[tag=br.alive,gamemode=!spectator,nbt=!{Health:0.0f}] at @s run effect give @s minecraft:hunger 20 3 true
