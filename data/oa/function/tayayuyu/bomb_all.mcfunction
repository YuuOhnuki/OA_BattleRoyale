tellraw @a[tag=br.playing] {text:"たやゆゆ変態ガチャ：TNT",color:"green"}
tellraw @a[tag=br.playing] {"text": " → 全員の足元にTNT演出。1秒後、半径4mに最大6HP（地形破壊なし）", "color": "gray"}
execute as @a[tag=br.alive,gamemode=!spectator,nbt=!{Health:0.0f}] at @s run function oa:tayayuyu/bomb_spawn
