execute unless entity @s[tag=oa.practice] run return run tellraw @s {text:"練習場の中で使ってください。",color:"yellow"}
scoreboard players operation @s oa.dpsb = @s br.st_dmg
scoreboard players set @s oa.dpst 200
tellraw @s {text:"【ダメージ計測】10秒間の与ダメージを測ります。スタート！",color:"gold"}
playsound minecraft:block.note_block.bell player @s ~ ~ ~ 1 1.5
