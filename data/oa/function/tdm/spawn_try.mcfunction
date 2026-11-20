scoreboard players add #spawn_try tdm.sys 1
execute store result score #spawn_roll tdm.sys run random value 0..2
execute if score @s tdm.team matches 1 if score #spawn_roll tdm.sys matches 0 run tp @s -46.5 65 -27.5 -90 0
execute if score @s tdm.team matches 1 if score #spawn_roll tdm.sys matches 1 run tp @s -46.5 65 0.5 -90 0
execute if score @s tdm.team matches 1 if score #spawn_roll tdm.sys matches 2 run tp @s -46.5 65 28.5 -90 0
execute if score @s tdm.team matches 2 if score #spawn_roll tdm.sys matches 0 run tp @s 46.5 65 -27.5 90 0
execute if score @s tdm.team matches 2 if score #spawn_roll tdm.sys matches 1 run tp @s 46.5 65 0.5 90 0
execute if score @s tdm.team matches 2 if score #spawn_roll tdm.sys matches 2 run tp @s 46.5 65 28.5 90 0
execute if score #spawn_try tdm.sys matches 6.. run return 0
execute if score @s tdm.team matches 1 at @s if entity @a[tag=tdm.player,tag=br.alive,scores={tdm.team=2},distance=..12] run return run function oa:tdm/spawn_try
execute if score @s tdm.team matches 2 at @s if entity @a[tag=tdm.player,tag=br.alive,scores={tdm.team=1},distance=..12] run return run function oa:tdm/spawn_try
