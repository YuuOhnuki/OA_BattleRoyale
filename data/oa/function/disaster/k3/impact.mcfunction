playsound minecraft:entity.generic.explode hostile @a[distance=..48] ~ ~ ~ 2 0.8
particle minecraft:explosion_emitter ~ ~0.5 ~
particle minecraft:flame ~ ~0.5 ~ 1 0.5 1 0.1 40 force @a[distance=..64]
# 屋根・木・天井の下にいる人は当たらない（足元の真上の最上面より0.9ブロック以上低ければ屋根の下）
# 1.9.163: 判定の箱（dx/dy/dz=0,40,0）は位置から高さ41ブロック分なので、最上面−41.9 から始めて上端を最上面−0.9 にする。1.9.162 までは −40.9 で上端が最上面＋0.1 になり、外にいる人も屋根の下と判定されてダメージが入っていなかった
execute as @a[tag=br.alive,distance=..3.5] at @s positioned over world_surface positioned ~ ~-41.9 ~ unless entity @s[dx=0,dy=40,dz=0] run damage @s 12 minecraft:explosion
execute as @a[tag=br.alive,distance=3.5..5.5] at @s positioned over world_surface positioned ~ ~-41.9 ~ unless entity @s[dx=0,dy=40,dz=0] run damage @s 6 minecraft:explosion
kill @s
