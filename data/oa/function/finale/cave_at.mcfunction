# 1.9.171: 洞窟の終盤演出の本体（神殿の床の中心の立ち位置で実行）。#fstep は 0→1→2 を0.4秒ごとに回る
# 床と天井のランプの点滅（交互・回転・逆回転）
function oa:maps/cave/finale_lamps
# 神殿：中心の光の爆発、柱の光の柱、天井近くではじける光
execute if score #fstep br.tmp matches 0 run particle minecraft:end_rod ~ ~3 ~ 0 0 0 0.35 120 force @a[tag=br.playing,distance=..160]
execute if score #fstep br.tmp matches 0 run particle minecraft:dust{color:[0.75,0.35,1.0],scale:2.5} ~ ~0.3 ~ 7 0.1 7 0 120 force @a[tag=br.playing,distance=..160]
execute if score #fstep br.tmp matches 1 run function oa:maps/cave/finale_pillars
execute if score #fstep br.tmp matches 1 run particle minecraft:sonic_boom ~ ~2 ~ 0 0 0 0 1 force @a[tag=br.playing,distance=..160]
execute if score #fstep br.tmp matches 1 run particle minecraft:dust{color:[0.2,0.9,1.0],scale:2.5} ~ ~0.3 ~ 12 0.1 12 0 160 force @a[tag=br.playing,distance=..160]
execute if score #fstep br.tmp matches 2 run particle minecraft:firework ~7 ~13 ~4 0 0 0 0.3 90 force @a[tag=br.playing,distance=..160]
execute if score #fstep br.tmp matches 2 run particle minecraft:firework ~-6 ~12 ~-5 0 0 0 0.3 90 force @a[tag=br.playing,distance=..160]
execute if score #fstep br.tmp matches 2 run particle minecraft:electric_spark ~ ~10 ~ 6 3 6 0.3 120 force @a[tag=br.playing,distance=..160]
execute if score #fstep br.tmp matches 2 run particle minecraft:dust{color:[1.0,0.8,0.2],scale:2.5} ~ ~0.3 ~ 18 0.1 18 0 200 force @a[tag=br.playing,distance=..160]
execute if score #fstep br.tmp matches 0..2 run particle minecraft:soul_fire_flame ~ ~1 ~ 14 1 14 0.02 25 force @a[tag=br.playing,distance=..160]
execute if score #fstep br.tmp matches 0 run particle minecraft:falling_dust{block_state:"minecraft:stone"} ~ ~16 ~ 16 2 16 0 60 force @a[tag=br.playing,distance=..160]
# 洞窟のどこにいても：各プレイヤーのまわりにきらめき（終盤の合図）
execute if score #fstep br.tmp matches 0 as @a[tag=br.playing] at @s run particle minecraft:wax_on ~ ~1.5 ~ 4 2 4 0 12 force @s
execute if score #fstep br.tmp matches 2 as @a[tag=br.playing] at @s run particle minecraft:glow ~ ~1.5 ~ 4 2 4 0 10 force @s
# 音（ドン・チッ・キーンの3拍）
execute if score #fstep br.tmp matches 0 as @a[tag=br.playing] at @s run playsound minecraft:block.note_block.basedrum ambient @s ~ ~ ~ 1 0.6
execute if score #fstep br.tmp matches 0 run playsound minecraft:entity.warden.heartbeat ambient @a[tag=br.playing,distance=..160] ~ ~ ~ 1.5 0.8
execute if score #fstep br.tmp matches 1 as @a[tag=br.playing] at @s run playsound minecraft:block.note_block.hat ambient @s ~ ~ ~ 0.8 1.2
execute if score #fstep br.tmp matches 1 run playsound minecraft:entity.warden.sonic_boom ambient @a[tag=br.playing,distance=..160] ~ ~ ~ 0.6 1.4
execute if score #fstep br.tmp matches 2 as @a[tag=br.playing] at @s run playsound minecraft:block.amethyst_block.chime ambient @s ~ ~ ~ 1 1.2
execute if score #fstep br.tmp matches 2 run playsound minecraft:entity.firework_rocket.twinkle ambient @a[tag=br.playing,distance=..160] ~ ~10 ~ 1.5 1.0
