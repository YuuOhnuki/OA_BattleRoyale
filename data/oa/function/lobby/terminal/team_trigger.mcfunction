execute unless score #state br.state matches 0 run return 0
execute if entity @s[tag=oa.practice] run return 0
execute unless score @s oa.lobby matches 101..102 run return run tellraw @s {text:"TDMは赤・青の2チームです",color:"yellow"}
function oa:br/join
execute if score @s oa.lobby matches 101 run scoreboard players set @s tdm.team 1
execute if score @s oa.lobby matches 102 run scoreboard players set @s tdm.team 2
tellraw @s {text:"TDMのチーム希望を更新しました。人数は開始時に均等化します",color:"aqua"}
