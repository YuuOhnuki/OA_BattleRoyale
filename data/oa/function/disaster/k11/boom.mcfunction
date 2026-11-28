particle minecraft:explosion ~ ~0.5 ~ 0 0 0 0 1 force @a[distance=..48]
particle minecraft:smoke ~ ~0.4 ~ 0.4 0.2 0.4 0.02 10 normal @a[distance=..32]
playsound minecraft:entity.generic.explode hostile @a[distance=..32] ~ ~ ~ 0.6 1.7
playsound minecraft:entity.pig.hurt neutral @a[distance=..24] ~ ~ ~ 0.8 1.3
# 1.9.264：半径3以内の生存者へ♥×1（同じ人へは2秒に1回まで。以前は半径2.5）
execute as @a[tag=br.alive,gamemode=!spectator,distance=..3,scores={br.dpig=..0}] run function oa:disaster/k11/hit
