
execute if data storage oa_map2:job {working:1b} run return run tellraw @s {text:"マップ生成・削除の処理を先に完了してください。",color:"yellow"}
execute unless score #state br.state matches 0 run return run tellraw @s {text:"試合停止中に実行してください。",color:"red"}
execute if data storage oa_map2:args {dim:"oa:br"} unless score #state oa.map2 matches 0 run return run tellraw @s {text:"BRマップは生成済みです。再生成する場合は管理ブックから削除してください。",color:"yellow"}
scoreboard players set #br_dim oa.map2 0
execute in oa:br run scoreboard players set #br_dim oa.map2 1
execute if score #br_dim oa.map2 matches 0 run return run tellraw @s {text:"BRディメンションを読み込むため、サーバーを再起動してください。",color:"red"}
data merge storage oa_map2:args {dim:"oa:br",x:0,y:80,z:0,center_y:70}
scoreboard players set #mode oa.map2 0
data modify storage oa_map2:job holding set value 0b
function oa:map/internal/job/begin
