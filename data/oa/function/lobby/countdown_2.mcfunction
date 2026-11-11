title @a[tag=br.lobby] times 0 18 2
title @a[tag=br.lobby] subtitle {text:"試合開始まで",color:"gold"}
title @a[tag=br.lobby] title {text:"2",color:"yellow",bold:true}
execute as @a[tag=br.lobby] at @s run playsound minecraft:block.note_block.pling player @s ~ ~ ~ 0.8 1.2
execute as @a[tag=br.lobby] at @s run particle minecraft:end_rod ~ ~1 ~ 0.7 1 0.7 0.02 12 normal @s

execute as @a[tag=br.lobby] at @s run particle minecraft:firework ~ ~1 ~ 0.8 1 0.8 0.03 20 normal @a[distance=..24]
