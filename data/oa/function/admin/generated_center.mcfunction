execute unless score #state br.state matches 0 run return 0
execute unless data storage oa_map2:args center_y run return run tellraw @s {text:"自動生成マップの基準地点が未登録です。現在地の中心登録かマップ生成を行ってください。",color:"red"}
function oa:map/internal/center with storage oa_map2:args
function oa:admin/status
