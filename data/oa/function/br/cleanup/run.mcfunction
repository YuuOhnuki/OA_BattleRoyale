execute unless score #state br.state matches 0 run return run tellraw @s {text:"試合停止中だけ使用できます",color:"red"}
execute if score #busy br.clean matches 1 run return 0
execute unless data storage oa:br center run return run tellraw @s {text:"先に中心を登録してください",color:"red"}
scoreboard players set #state br.state 4
scoreboard players set #mode br.clean 3
function oa:br/cleanup/begin
