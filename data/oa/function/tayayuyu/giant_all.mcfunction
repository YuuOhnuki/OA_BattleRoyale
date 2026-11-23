tellraw @a[tag=br.playing] {text:"たやゆゆ変態ガチャ：全員巨大化",color:"#12a88f"}
tellraw @a[tag=br.playing] {text:" → 生存者全員が10秒 巨大化",color:"gray"}
execute as @a[tag=br.alive,gamemode=!spectator,tag=!oa.dead] at @s unless dimension oa:br_cave run function oa:tayayuyu/size {amount:4.0,ticks:200}
execute as @a[tag=br.alive,gamemode=!spectator,tag=!oa.dead] at @s if dimension oa:br_cave run function oa:tayayuyu/size {amount:1.5,ticks:200}
