tellraw @a[tag=br.playing] {text:"たやゆゆ変態ガチャ：復活",color:"green"}
tellraw @a[tag=br.playing] {"text": " → 倒れた参加者が復活", "color": "gray"}
execute as @a[tag=br.playing,tag=!br.alive,tag=!br.gm_override,tag=!oa.dead] if score @s br.round = #round br.round at @s run function oa:tayayuyu/revive
