scoreboard players add @s br.sup 1
execute if score @s br.sup matches 180.. run return run kill @s
# 1.9.168: 着地後の光の柱はなし（予告から着地までの柱は br/supply/second のまま）
particle minecraft:firework ~ ~0.5 ~ 0.5 0.3 0.5 0.02 6 force @a[tag=br.playing,distance=..160]
