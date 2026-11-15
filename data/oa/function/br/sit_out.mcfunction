# 1.9.186: 試合に参加しないで、ロビー（練習場）に残る（案内の本「参加しない」、管理者の「離脱」）。待機中だけ
execute unless score #state br.state matches 0 run return run tellraw @s {text:"試合中は変更できません。",color:"yellow"}
execute if entity @s[tag=br.playing] run return 0
execute if entity @s[tag=br.watch] run gamemode adventure @s
execute if entity @s[tag=br.watch] run team leave @s
execute if entity @s[tag=br.watch,tag=!oa.practice] if data storage oa:lobby origin{ready:1b} run function oa:lobby/center with storage oa:lobby origin
tag @s remove br.watch
function oa:br/leave
