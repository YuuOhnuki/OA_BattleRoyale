execute as @a[tag=br.alive,sort=random,limit=2] at @s run function oa:disaster/k3/aim
execute as @a[tag=br.alive,limit=1] at @s as @e[type=minecraft:marker,tag=br.dis_mark,distance=..500] at @s run function oa:disaster/k3/mark
