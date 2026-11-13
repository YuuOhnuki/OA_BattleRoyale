# 空が見える場所か：足元の真上の最上面（world_surface）より0.9ブロック以上低ければ屋根・木の下（スラブや雪の上でも誤判定しない余裕）
execute at @s positioned over world_surface positioned ~ ~-40.9 ~ unless entity @s[dx=0,dy=40,dz=0] run function oa:disaster/k1/hit
