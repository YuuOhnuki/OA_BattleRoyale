title @a[tag=br.playing] times 5 45 10
title @a[tag=br.playing] subtitle {text:"中身を強化して補充しました",color:"yellow"}
title @a[tag=br.playing] title {text:"チェスト補充！",color:"gold"}
execute as @a[tag=br.playing] at @s run playsound minecraft:block.chest.open player @s ~ ~ ~ 1 1

tellraw @a[tag=br.playing] {text:"チェストが補充されました。",color:"gold"}
