execute as @e[type=minecraft:chicken,tag=oa.dis_chicken,sort=random,limit=10] at @s run function oa:disaster/k8/fx
execute as @a[tag=br.alive,gamemode=!spectator] if entity @e[type=minecraft:chicken,tag=oa.dis_chicken,distance=..8] run function oa:disaster/k8/msg
