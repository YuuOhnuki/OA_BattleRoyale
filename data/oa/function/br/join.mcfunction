execute if entity @s[tag=oa.practice] run return 0
execute unless entity @s[type=minecraft:player] run return 0
execute if score #state br.state matches 1.. run return run tellraw @s {text:"参加登録しました。羊毛でチームを選択できます。",color:"aqua"}
execute if score @s br.saved matches 1 run return run tellraw @s {text:"参加登録しました。羊毛でチームを選択できます。",color:"aqua"}
execute if entity @s[tag=br.watch] run gamemode adventure @s
execute if entity @s[tag=br.watch] run team leave @s
tag @s remove br.watch
execute unless score @s oa.id matches 1.. run function oa:internal/id
scoreboard players add @s br.pick 0
scoreboard players add @s br.saved 0
tag @s add br.lobby
function oa:br/team/sync
tellraw @s {text:"参加登録しました。羊毛でチームを選択できます。",color:"aqua"}

scoreboard players add @s br.restore 0
scoreboard players add @s br.retry 0

function oa:lobby/guide/book
