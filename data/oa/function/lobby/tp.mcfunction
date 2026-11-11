execute unless entity @s[type=minecraft:player] run return 0
execute unless score #state br.state matches 0 run return run tellraw @s {text:"ロビー移動は試合・清掃の停止中だけです",color:"red"}
execute if score @s br.saved matches 1 run return run tellraw @s {text:"先に保存品の復元が必要です",color:"red"}
execute unless data storage oa:lobby origin{ready:1b} run return run tellraw @s {text:"まだロビーが作成されていません",color:"red"}
function oa:lobby/warp with storage oa:lobby origin
