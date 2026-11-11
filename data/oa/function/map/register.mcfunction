execute unless score #state oa.map2 matches 3 run return run tellraw @s {text:"生成完了後に実行してください。停止中はresume",color:"red"}
execute unless score #state br.state matches 0 run return run tellraw @s {text:"試合を停止してから実行してください",color:"red"}
scoreboard players set #mode oa.map2 1
function oa:map/internal/job/begin
