# ネザーマップの終盤演出：溶岩の火柱・火の粉・灰・魂の火。ダメージや地形変更は行わない
function oa:finale/bursts
function oa:finale/lamps
execute unless score #fstep br.tmp matches 1 run particle minecraft:lava ~ ~-6 ~ 6 4 6 0 10 force @a[tag=br.playing,distance=..160]
execute unless score #fstep br.tmp matches 1 run particle minecraft:flame ~ ~-6 ~ 0.6 14 0.6 0.04 20 force @a[tag=br.playing,distance=..160]
execute unless score #fstep br.tmp matches 1 run particle minecraft:soul_fire_flame ~ ~-4 ~ 9 6 9 0.02 16 force @a[tag=br.playing,distance=..160]
execute unless score #fstep br.tmp matches 1 run particle minecraft:large_smoke ~ ~2 ~ 14 6 14 0.02 10 force @a[tag=br.playing,distance=..160]
execute unless score #fstep br.tmp matches 1 run particle minecraft:ash ~ ~ ~ 20 10 20 0 50 force @a[tag=br.playing,distance=..160]
execute if score #fstep br.tmp matches 0 run playsound minecraft:block.lava.pop ambient @a[tag=br.playing,distance=..160] ~ ~-6 ~ 2 0.6
execute if score #fstep br.tmp matches 1 run playsound minecraft:entity.blaze.shoot ambient @a[tag=br.playing,distance=..160] ~ ~ ~ 1.5 0.6
execute if score #fstep br.tmp matches 2 run playsound minecraft:entity.generic.explode ambient @a[tag=br.playing,distance=..160] ~ ~ ~ 1 0.5
