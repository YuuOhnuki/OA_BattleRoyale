tellraw @a[tag=br.playing] [{text:"◆ ",color:"aqua"},{text:"安置の収縮が完了しました",color:"aqua",bold:true}]
execute as @a[tag=br.playing] at @s run playsound minecraft:block.note_block.chime master @s ~ ~ ~ 0.7 1.4
