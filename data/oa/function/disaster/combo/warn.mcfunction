scoreboard players remove #dc_warn br.tmp 1
execute if score #dc_warn br.tmp matches 3 as @a[tag=br.playing] at @s run playsound minecraft:block.note_block.pling master @s ~ ~ ~ 1 0.9
execute if score #dc_warn br.tmp matches 2 as @a[tag=br.playing] at @s run playsound minecraft:block.note_block.pling master @s ~ ~ ~ 1 1.1
execute if score #dc_warn br.tmp matches 1 as @a[tag=br.playing] at @s run playsound minecraft:block.note_block.pling master @s ~ ~ ~ 1 1.4
execute if score #dc_warn br.tmp matches 1.. run return 0
function oa:disaster/start_planned
function oa:disaster/count
tellraw @a[tag=br.playing] {text:"⚠ 災害コンボ発生！",color:"dark_red",bold:true}
