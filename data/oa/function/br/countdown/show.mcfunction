title @a[tag=br.playing] subtitle {text:"その場で待機",color:"gray"}
$title @a[tag=br.playing] title {text:"$(n)",color:"$(color)",bold:true}
$execute as @a[tag=br.playing] at @s run playsound minecraft:block.note_block.pling master @s ~ ~ ~ 1 $(pitch)
