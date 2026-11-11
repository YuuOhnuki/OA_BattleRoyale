tellraw @a[tag=br.playing] {text:"たやゆゆ変態ガチャ：復活",color:"green"}
tellraw @a[tag=br.playing] {"text": " → この試合で倒れた参加者が復活", "color": "gray"}
execute as @a[tag=br.playing,tag=!br.alive,tag=!br.gm_override,nbt=!{Health:0.0f}] if score @s br.round = #round br.round at @s run function oa:tayayuyu/revive
