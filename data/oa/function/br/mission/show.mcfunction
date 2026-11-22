execute unless score #state br.state matches 1 run return run tellraw @s {text:"お題は試合中に表示されます。",color:"yellow"}
execute unless data storage oa:br mission.name run function oa:br/mission/name
function oa:br/mission/show_say with storage oa:br mission
execute if score @s br.mdone matches 1 run tellraw @s {text:"（達成済み）",color:"green"}
