execute if entity @s[tag=oa.curse_guard] run function oa:curse/blocked
# 1.9.173: 無効化が続いた回数（失敗で0）。3回続くと「走り撃ち」
execute if entity @s[tag=oa.curse_guard] run scoreboard players add @s br.a_kstr 1
execute unless entity @s[tag=oa.curse_guard] run scoreboard players set @s br.a_kstr 0
execute if score @s br.a_kstr matches 3.. if entity @s[type=minecraft:player,tag=br.playing] run function oa:ach/give {id:"killing_streak",name:"走り撃ち"}
