playsound minecraft:entity.generic.explode hostile @a[distance=..48] ~ ~ ~ 2 0.8
particle minecraft:explosion_emitter ~ ~0.5 ~
particle minecraft:flame ~ ~0.5 ~ 1 0.5 1 0.1 40 force @a[distance=..64]
# 屋根・木・天井の下にいる人は当たらない（足元の真上の最上面より0.9ブロック以上低ければ屋根の下）
execute as @a[tag=br.alive,distance=..3.5] at @s positioned over world_surface positioned ~ ~-40.9 ~ unless entity @s[dx=0,dy=40,dz=0] run damage @s 12 minecraft:explosion
execute as @a[tag=br.alive,distance=3.5..5.5] at @s positioned over world_surface positioned ~ ~-40.9 ~ unless entity @s[dx=0,dy=40,dz=0] run damage @s 6 minecraft:explosion
kill @s
