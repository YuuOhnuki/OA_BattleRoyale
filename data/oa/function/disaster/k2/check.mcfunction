# 空が見える場所か：足元の真上の最上面（world_surface）より0.9ブロック以上低ければ屋根・木の下（スラブや雪の上でも誤判定しない余裕）
# 1.9.163: 判定の箱（dx/dy/dz=0,40,0）は位置から高さ41ブロック分なので、最上面−41.9 から始めて上端を最上面−0.9 にする。1.9.162 までは −40.9 で上端が最上面＋0.1 になり、外にいる人も屋根の下と判定されてダメージが入っていなかった
execute at @s positioned over world_surface positioned ~ ~-41.9 ~ unless entity @s[dx=0,dy=40,dz=0] run function oa:disaster/k2/hit
