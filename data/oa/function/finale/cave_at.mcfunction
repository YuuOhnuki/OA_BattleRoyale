# 1.9.171: 洞窟の終盤演出の本体（神殿の床の中心の立ち位置で実行）。#fstep は 0→1→2 を0.4秒ごとに回る
# 1.9.174: 演出を減らした（衝撃波・花火・落ちる砂・プレイヤーのまわりの光る粒・ウォーデンの音をやめ、粒の数を半分以下に）
# 床と天井のランプの点滅（交互・回転・逆回転）
function oa:maps/cave/finale_lamps
# 神殿：中心の光、柱の光の柱、床に広がる色の粒
execute if score #fstep br.tmp matches 0 run particle minecraft:end_rod ~ ~3 ~ 0 0 0 0.25 40 force @a[tag=br.playing,distance=..160]
execute if score #fstep br.tmp matches 0 run particle minecraft:dust{color:[0.75,0.35,1.0],scale:2.0} ~ ~0.3 ~ 7 0.1 7 0 50 force @a[tag=br.playing,distance=..160]
execute if score #fstep br.tmp matches 1 run function oa:maps/cave/finale_pillars
execute if score #fstep br.tmp matches 1 run particle minecraft:dust{color:[0.2,0.9,1.0],scale:2.0} ~ ~0.3 ~ 12 0.1 12 0 60 force @a[tag=br.playing,distance=..160]
execute if score #fstep br.tmp matches 2 run particle minecraft:electric_spark ~ ~10 ~ 6 3 6 0.2 40 force @a[tag=br.playing,distance=..160]
execute if score #fstep br.tmp matches 2 run particle minecraft:dust{color:[1.0,0.8,0.2],scale:2.0} ~ ~0.3 ~ 18 0.1 18 0 70 force @a[tag=br.playing,distance=..160]
# 音（ドン・チッ・キーンの3拍。本人の位置で小さめに）
execute if score #fstep br.tmp matches 0 as @a[tag=br.playing] at @s run playsound minecraft:block.note_block.basedrum ambient @s ~ ~ ~ 0.7 0.6
execute if score #fstep br.tmp matches 1 as @a[tag=br.playing] at @s run playsound minecraft:block.note_block.hat ambient @s ~ ~ ~ 0.5 1.2
execute if score #fstep br.tmp matches 2 as @a[tag=br.playing] at @s run playsound minecraft:block.amethyst_block.chime ambient @s ~ ~ ~ 0.7 1.2
