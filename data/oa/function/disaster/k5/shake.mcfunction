effect give @s minecraft:nausea 5 0 true
effect give @s minecraft:slowness 2 0 true
particle minecraft:poof ~ ~0.1 ~ 0.5 0.1 0.5 0.02 6 normal @a[distance=..30]
playsound minecraft:block.deepslate.break player @s ~ ~ ~ 2 0.5
execute store result score #q br.tmp run random value 1..2
execute if score #q br.tmp matches 1 run tag @s add br.dis_msg
execute if score #q br.tmp matches 1 if score #dis_phase br.tmp matches 1 run title @s actionbar {text:"地面の揺れでよろめいた！",color:"gold"}
execute if score #q br.tmp matches 1 run damage @s 3 minecraft:fall
