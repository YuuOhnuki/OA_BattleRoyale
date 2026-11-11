execute unless entity @s[tag=br.admin] run return 0
execute unless score #state br.state matches 0 run return run tellraw @s {text:"展示更新は試合待機中に行ってください。",color:"yellow"}
execute unless data storage oa:lobby origin{ready:1b} run return run tellraw @s {text:"先にロビーを登録してください。",color:"yellow"}
data remove storage oa:lobby origin.gallery
function oa:lobby/gallery/ensure with storage oa:lobby origin
tellraw @s {text:"展示更新を受け付けました。ロビーが読み込まれると反映します。",color:"aqua"}
