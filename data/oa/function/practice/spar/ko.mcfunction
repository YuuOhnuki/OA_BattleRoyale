effect give @s minecraft:instant_health 1 10 true
effect give @s minecraft:regeneration 3 4 true
execute in oa:practice run tp @s 0.5 65 35.5 180 0
scoreboard players add @s oa.sparko 1
title @s title {text:"KO！",color:"red",bold:true}
tellraw @a[tag=oa.spar] [{selector:"@s"},{text:" がKOされました！",color:"gold"}]
playsound minecraft:entity.player.death player @s ~ ~ ~ 1 1
