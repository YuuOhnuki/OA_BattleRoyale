playsound minecraft:entity.generic.explode hostile @a[distance=..48] ~ ~ ~ 2 0.8
particle minecraft:explosion_emitter ~ ~0.5 ~
particle minecraft:flame ~ ~0.5 ~ 1 0.5 1 0.1 40 force @a[distance=..64]
execute as @a[tag=br.alive,distance=..3.5] run damage @s 7 minecraft:explosion
execute as @a[tag=br.alive,distance=3.5..5.5] run damage @s 3 minecraft:explosion
kill @s
