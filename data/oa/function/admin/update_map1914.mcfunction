execute unless score #state br.state matches 0 run return run tellraw @s {text:"試合を停止してから実行してください。",color:"red"}
execute unless data storage oa_map2:args center_y run return run tellraw @s {text:"先にマップの中心を登録してください。",color:"red"}
function oa:map/rebuild
