execute unless entity @s[tag=br.admin] run return run tellraw @s {text:"登録済み管理者のみ実行できます。",color:"red"}
execute unless score #state br.state matches 0 run return run tellraw @s {text:"試合停止中に実行してください。",color:"red"}
execute if data storage oa_map2:job {working:1b} run return run tellraw @s {text:"マップの生成・削除が処理中です。",color:"yellow"}
execute unless data storage oa_map2:args center_y run return run tellraw @s {text:"登録済みマップがありません。",color:"yellow"}
data modify storage oa_map2:job working set value 1b
data modify storage oa_map2:job deleting set value 1b
data modify storage oa_map2:args tile set value 0
scoreboard players set #state oa.map2 4
function oa:map/internal/delete/dispatch
