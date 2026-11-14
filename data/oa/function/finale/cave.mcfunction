# 1.9.167: 洞窟マップの終盤演出（神殿の中心で実行）。紫水晶のきらめき・魂の光・天井から落ちる砂ぼこり・地鳴り。ダメージや地形変更は行わない
execute unless score #fstep br.tmp matches 1 run particle minecraft:end_rod ~ ~6 ~ 12 5 12 0.01 30 force @a[tag=br.playing,distance=..160]
execute unless score #fstep br.tmp matches 1 run particle minecraft:soul_fire_flame ~ ~1 ~ 14 1 14 0.01 20 force @a[tag=br.playing,distance=..160]
execute if score #fstep br.tmp matches 1 run particle minecraft:falling_dust{block_state:"minecraft:stone"} ~ ~14 ~ 16 2 16 0 60 force @a[tag=br.playing,distance=..160]
execute if score #fstep br.tmp matches 2 run particle minecraft:wax_on ~ ~4 ~ 14 4 14 0 40 force @a[tag=br.playing,distance=..160]
execute if score #fstep br.tmp matches 0 run playsound minecraft:block.amethyst_block.chime ambient @a[tag=br.playing,distance=..160] ~ ~ ~ 2 0.8
execute if score #fstep br.tmp matches 1 run playsound minecraft:entity.warden.heartbeat ambient @a[tag=br.playing,distance=..160] ~ ~ ~ 1.5 0.8
execute if score #fstep br.tmp matches 2 run playsound minecraft:block.sculk_shrieker.shriek ambient @a[tag=br.playing,distance=..160] ~ ~ ~ 0.6 1.2
