# 発光は2秒ずつ付け直す（終わったら自然に消える。ほかの仕組みの長い発光は消さない）
effect give @a[tag=br.alive,gamemode=!spectator] minecraft:glowing 2 0 true
effect give @a[tag=br.alive,gamemode=!spectator] minecraft:speed 2 0 true
# 花火は1秒に最大8人の頭上（負荷を抑える）
execute as @a[tag=br.alive,gamemode=!spectator,sort=random,limit=8] at @s run function oa:disaster/k9/firework
# 赤い空の演出（本人の上空に赤い粒）
execute as @a[tag=br.playing] at @s run particle minecraft:dust{color:[0.75,0.0,0.05],scale:3.0} ~ ~9 ~ 10 3 10 0 20 normal @s
