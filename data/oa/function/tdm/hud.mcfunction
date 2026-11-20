scoreboard players set #seconds tdm.sys 6000
scoreboard players operation #seconds tdm.sys -= #time tdm.sys
scoreboard players add #seconds tdm.sys 19
scoreboard players set #twenty tdm.sys 20
scoreboard players operation #seconds tdm.sys /= #twenty tdm.sys
scoreboard players operation 残り秒 tdm.board = #seconds tdm.sys
scoreboard players operation 赤チーム tdm.board = #red tdm.points
scoreboard players operation 青チーム tdm.board = #blue tdm.points
execute if score #seconds tdm.sys matches 60 run tellraw @a[tag=tdm.player] {text:"残り1分！",color:"gold"}
execute as @a[tag=tdm.player,tag=br.alive] run function oa:tdm/hud_player
execute if score #seconds tdm.sys matches 1..10 as @a[tag=tdm.player] at @s run playsound minecraft:block.note_block.hat player @s ~ ~ ~ 0.6 1.3
