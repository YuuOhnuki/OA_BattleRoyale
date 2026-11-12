# macro: key  切り替えの結果をロビーの全員へ知らせる（@s=押したプレイヤー）
$execute unless data storage oa:maps {current:"$(key)"} run return run tellraw @s {text:"マップを切り替えられませんでした。",color:"red"}
$tellraw @a[tag=br.lobby_now] [{selector:"@s",color:"yellow"},{text:" が試合のマップを「",color:"gray"},{nbt:"defs.$(key).name",storage:"oa:maps",interpret:true,color:"gold"},{text:"」に切り替えました。",color:"gray"}]
execute as @a[tag=br.lobby_now] at @s run playsound minecraft:block.note_block.chime player @s ~ ~ ~ 1 1.4
