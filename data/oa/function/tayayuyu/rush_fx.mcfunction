# 1.9.192: 爆速の間の演出（毎 tick、本人として）。足元の風の粒・炎の尾、1秒ごとに風の音
particle minecraft:cloud ~ ~0.2 ~ 0.25 0.1 0.25 0.02 2 normal @a[distance=..32]
particle minecraft:small_flame ~ ~0.6 ~ 0.2 0.3 0.2 0.01 2 normal @a[distance=..32]
scoreboard players set #c20 oa.tmp 20
scoreboard players operation #rush_s oa.tmp = @s oa.grush
scoreboard players operation #rush_s oa.tmp %= #c20 oa.tmp
execute if score #rush_s oa.tmp matches 0 run playsound minecraft:entity.breeze.wind_burst player @a[distance=..24] ~ ~ ~ 0.6 1.4
execute if score #rush_s oa.tmp matches 10 run playsound minecraft:item.elytra.flying player @s ~ ~ ~ 0.25 1.6
