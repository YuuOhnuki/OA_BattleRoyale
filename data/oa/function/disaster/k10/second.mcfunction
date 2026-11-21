execute as @e[type=minecraft:marker,tag=oa.dis_tornado] at @s run playsound minecraft:entity.breeze.idle_air ambient @a[distance=..40] ~ ~3 ~ 1.5 0.5
execute as @e[type=minecraft:marker,tag=oa.dis_tornado] at @s as @a[tag=br.alive,gamemode=!spectator,distance=..20] run function oa:disaster/k10/msg
