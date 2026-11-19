scoreboard players remove #dc_warn br.tmp 1
execute if score #dc_warn br.tmp matches 3 as @a[tag=br.playing] at @s run playsound minecraft:block.note_block.pling master @s ~ ~ ~ 1 0.9
execute if score #dc_warn br.tmp matches 2 as @a[tag=br.playing] at @s run playsound minecraft:block.note_block.pling master @s ~ ~ ~ 1 1.1
execute if score #dc_warn br.tmp matches 1 as @a[tag=br.playing] at @s run playsound minecraft:block.note_block.pling master @s ~ ~ ~ 1 1.4
execute if score #dc_warn br.tmp matches 1.. run return 0
scoreboard players operation #dc_save br.tmp = #dis_left br.tmp
execute if score #dc_p1 br.tmp matches 1 run function oa:disaster/combo/start_k1
execute if score #dc_p2 br.tmp matches 1 run function oa:disaster/combo/start_k2
execute if score #dc_p3 br.tmp matches 1 run function oa:disaster/combo/start_k3
execute if score #dc_p4 br.tmp matches 1 run function oa:disaster/combo/start_k4
execute if score #dc_p5 br.tmp matches 1 run function oa:disaster/combo/start_k5
execute if score #dc_p6 br.tmp matches 1 run function oa:disaster/combo/start_k6
scoreboard players operation #dis_left br.tmp = #dc_save br.tmp
tellraw @a[tag=br.playing] {text:"⚠ 災害コンボ発生！",color:"dark_red",bold:true}
