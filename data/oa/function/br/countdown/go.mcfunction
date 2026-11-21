scoreboard players set #countdown br.tmp 0
execute as @a[tag=oa.countdown] run function oa:br/countdown/unlock
title @a[tag=br.playing] times 0 30 10
title @a[tag=br.playing] subtitle {text:"試合開始！",color:"yellow"}
title @a[tag=br.playing] title {text:"スタート！",color:"gold",bold:true}
execute as @a[tag=br.playing] at @s run playsound minecraft:block.note_block.pling master @s ~ ~ ~ 1 1.8
execute as @a[tag=br.playing] at @s run playsound minecraft:entity.ender_dragon.growl player @s ~ ~ ~ 0.8 1.2
