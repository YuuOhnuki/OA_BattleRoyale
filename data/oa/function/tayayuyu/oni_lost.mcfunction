# 1.9.192: 鬼が倒れた・抜けた。生存者のだれかに移す（いなければ終わり）
execute as @a[tag=oa.g_oni] run function oa:tayayuyu/oni_drop
execute unless entity @a[tag=br.alive,gamemode=!spectator,tag=!oa.dead] run return run function oa:tayayuyu/oni_reset
execute as @a[tag=br.alive,gamemode=!spectator,tag=!oa.dead,sort=random,limit=1] at @s run function oa:tayayuyu/oni_take
tellraw @a[tag=br.playing] [{text:"💣 鬼がいなくなったので、爆弾が ",color:"red"},{selector:"@a[tag=oa.g_oni]",color:"yellow"},{text:" に移った！",color:"red"}]
