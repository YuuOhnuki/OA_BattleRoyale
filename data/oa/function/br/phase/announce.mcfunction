title @a[tag=br.playing] times 5 45 10
$title @a[tag=br.playing] subtitle {text:"$(state)",color:"yellow"}
$title @a[tag=br.playing] title {text:"フェーズ $(phase)",color:"gold"}
$tellraw @a[tag=br.playing] {text:"フェーズ$(phase)：$(state)",color:"gold"}
execute as @a[tag=br.playing] at @s run playsound minecraft:block.beacon.activate player @s ~ ~ ~ 1 1.2
execute if score #shrinking br.flag matches 1 as @a[tag=br.playing] at @s run playsound minecraft:entity.ender_dragon.growl player @s ~ ~ ~ 0.5 1.5
