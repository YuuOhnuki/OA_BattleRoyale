tellraw @a[tag=br.playing] {text:"たやゆゆ変態ガチャ：元気百倍",color:"green"}
execute as @a[tag=br.alive,tag=!oa.practice,gamemode=!spectator] run function oa:tayayuyu/health_reveal
tellraw @a[tag=br.playing] {"text": " → 使用者だけ：最大体力＋10ハート・移動速度上昇II・再生I・跳躍力上昇II（45秒）、10ハート回復。全生存者は最初の10秒だけ発光", "color": "gray"}
# 1.9.192: 使用者だけ（以前は生存者全員）。名前も「体力」から変えた
execute if entity @s[tag=br.alive,gamemode=!spectator] run function oa:tayayuyu/health
particle minecraft:heart ~ ~1.5 ~ 0.5 0.5 0.5 0 12 normal @a[distance=..32]
playsound minecraft:entity.player.levelup player @a[distance=..32] ~ ~ ~ 1 1.2
