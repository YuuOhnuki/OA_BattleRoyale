$tellraw @a[tag=br.playing] [{text:"◆ ",color:"red"},{text:"安置の収縮完了まで ",color:"white"},{text:"$(left)",color:"red",bold:true}]
execute as @a[tag=br.playing] at @s run playsound minecraft:block.note_block.bell master @s ~ ~ ~ 0.6 1.2
