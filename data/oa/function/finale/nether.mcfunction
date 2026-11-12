# ネザーマップの終盤演出：溶岩の火柱・火の粉・灰・魂の火。ダメージや地形変更は行わない
function oa:finale/bursts
function oa:finale/lamps
particle minecraft:lava ~ ~-6 ~ 6 4 6 0 25 force @a[tag=br.playing,distance=..160]
particle minecraft:flame ~ ~-6 ~ 0.6 14 0.6 0.04 50 force @a[tag=br.playing,distance=..160]
particle minecraft:soul_fire_flame ~ ~-4 ~ 9 6 9 0.02 40 force @a[tag=br.playing,distance=..160]
particle minecraft:large_smoke ~ ~2 ~ 14 6 14 0.02 24 force @a[tag=br.playing,distance=..160]
particle minecraft:ash ~ ~ ~ 20 10 20 0 120 force @a[tag=br.playing,distance=..160]
execute if score #fstep br.tmp matches 0 run playsound minecraft:block.lava.pop ambient @a[tag=br.playing,distance=..160] ~ ~-6 ~ 4 0.6
execute if score #fstep br.tmp matches 1 run playsound minecraft:entity.blaze.shoot ambient @a[tag=br.playing,distance=..160] ~ ~ ~ 3 0.6
execute if score #fstep br.tmp matches 2 run playsound minecraft:entity.generic.explode ambient @a[tag=br.playing,distance=..160] ~ ~ ~ 2 0.5
