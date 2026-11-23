$data modify storage oa:map_choice key set value "$(key)"
execute if data storage oa:map_choice {key:"sky"} run return run function oa:lobby/terminal/select_map {key:"sky"}
execute unless entity @s[tag=br.host] unless entity @s[tag=br.admin] run return run tellraw @s {text:"会場の変更はホスト・管理者が行います",color:"yellow"}
execute if score #game oa.game matches 1 run return run tellraw @s {text:"TDMは専用アリーナを使います。BRのマップ選択は保存されています",color:"yellow"}
# macro: key  プレイヤー(@s)が押したボタンのマップへ、試合用マップを切り替える
$execute if data storage oa:maps {current:"$(key)"} run return run tellraw @s {text:"すでにこのマップが選ばれています。",color:"yellow"}
execute unless score #state br.state matches 0 run return run tellraw @s {text:"試合中・清掃中はマップを切り替えられません。",color:"red"}
execute if data storage oa_map2:job {working:1b} run return run tellraw @s {text:"マップの生成・削除の処理中です。終わってからもう一度押してください。",color:"yellow"}
$execute unless data storage oa:maps saved.$(key){state:3} run return run tellraw @s {text:"このマップはまだ生成されていません。管理者に生成してもらってください。",color:"red"}
$execute as @e[type=minecraft:marker,tag=oa.button_mapsel,limit=1] run function oa:map/select {key:"$(key)"}
$function oa:lobby/mapsel/after {key:"$(key)"}
