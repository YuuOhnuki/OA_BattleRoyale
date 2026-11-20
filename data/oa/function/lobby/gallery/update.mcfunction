execute unless entity @s[tag=br.admin] run return 0
execute unless score #state br.state matches 0 run return run tellraw @s {text:"展示更新は試合待機中に行ってください。",color:"yellow"}
execute unless data storage oa:lobby origin{ready:1b} run return run tellraw @s {text:"先にロビーを登録してください。",color:"yellow"}
execute if data storage oa:lobby origin{terminal:202} run return run tellraw @s {text:"旧ターミナルの展示は再建（oa.admin 14）で新しい出撃ターミナルに置き換えてください。",color:"yellow"}
# 1.9.203: 出撃ターミナルでは旧ギャラリーを作らず、表示・操作部品だけを置き直す
execute if data storage oa:lobby origin{terminal:203} run return run function oa:lobby/terminal/refresh with storage oa:lobby origin
data remove storage oa:lobby origin.gallery
function oa:lobby/gallery/ensure with storage oa:lobby origin
tellraw @s {text:"展示更新を受け付けました。ロビーが読み込まれると反映します。",color:"aqua"}
