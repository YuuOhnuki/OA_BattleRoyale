execute if data storage oa_map2:job {deleting:1b} run return 0
execute unless data storage oa_map2:args center_y run return run tellraw @s {text:"先に /function oa:map/create でBR会場を生成してください",color:"red"}
execute unless score #state br.state matches 0 run return run tellraw @s {text:"先に試合を停止してください",color:"red"}
function oa:map/pause
scoreboard players set #mode oa.map2 0
function oa:map/internal/job/begin
