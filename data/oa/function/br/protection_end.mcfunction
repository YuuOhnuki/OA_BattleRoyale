title @a[tag=br.playing] times 10 50 15
title @a[tag=br.playing] subtitle {text:"ここから戦闘開始！",color:"yellow"}
title @a[tag=br.playing] title {text:"保護期間終了",color:"red",bold:true}
execute as @a[tag=br.playing] at @s run playsound minecraft:entity.ender_dragon.growl player @s ~ ~ ~ 0.6 1.2
