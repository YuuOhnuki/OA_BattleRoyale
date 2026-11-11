scoreboard players add #celebration br.time 1
execute if score #celebration br.time matches 20 as @a[tag=br.winner,tag=br.playing] at @s run function oa:br/celebration/spark
execute if score #celebration br.time matches 40 as @a[tag=br.winner,tag=br.playing] at @s run function oa:br/celebration/spark
execute if score #celebration br.time matches 60 as @a[tag=br.winner,tag=br.playing] at @s run function oa:br/celebration/spark
execute if score #celebration br.time matches 80 as @a[tag=br.winner,tag=br.playing] at @s run function oa:br/celebration/spark
execute if score #celebration br.time matches 120.. run function oa:br/finish
