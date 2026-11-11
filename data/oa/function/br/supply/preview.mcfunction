tag @s remove br.supply_new
tag @s add br.supply_wait
execute store result score @s br.suptype run random value 1..3
execute store result score #sx br.tmp run data get entity @s Pos[0]
execute store result score #sz br.tmp run data get entity @s Pos[2]
scoreboard players set #20 br.tmp 20
scoreboard players operation #sx br.tmp /= #20 br.tmp
scoreboard players operation #sx br.tmp *= #20 br.tmp
scoreboard players operation #sz br.tmp /= #20 br.tmp
scoreboard players operation #sz br.tmp *= #20 br.tmp
tellraw @a[tag=br.playing] [{text:"✈ まもなく空中補給！（約15秒後） ",color:"gold",bold:true},{text:"おおよそ X:",color:"yellow"},{score:{name:"#sx",objective:"br.tmp"},color:"white"},{text:" Z:",color:"yellow"},{score:{name:"#sz",objective:"br.tmp"},color:"white"},{text:" の周辺",color:"gray"}]
execute if score @s br.suptype matches 1 run tellraw @a[tag=br.playing] {text:"種類：バランス（武器と回復）",color:"aqua"}
execute if score @s br.suptype matches 2 run tellraw @a[tag=br.playing] {text:"種類：回復・食料たっぷり",color:"green"}
execute if score @s br.suptype matches 3 run tellraw @a[tag=br.playing] {text:"種類：武器たっぷり（取り合い注意！）",color:"red"}
execute as @a[tag=br.playing] at @s run playsound minecraft:block.note_block.bell player @s ~ ~ ~ 1.2 1.4
