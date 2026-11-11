scoreboard players add @s br.sup 1
execute if score @s br.sup matches 180.. run return run kill @s
particle minecraft:end_rod ~ ~2 ~ 0.15 6 0.15 0.01 24 force @a[tag=br.playing,distance=..160]
particle minecraft:firework ~ ~0.5 ~ 0.5 0.3 0.5 0.02 6 force @a[tag=br.playing,distance=..160]
