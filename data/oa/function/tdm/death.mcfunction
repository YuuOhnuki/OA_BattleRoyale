execute unless score @s tdm.wait matches 1.. run function oa:tdm/clean_player
scoreboard players set @s oa.death 0
tag @s remove br.alive
scoreboard players set @s tdm.wait 60
scoreboard players set @s tdm.guard 0
scoreboard players set @s tdm.armor 0
function oa:br/clear_inventory
gamemode spectator @s
title @s actionbar {text:"3秒後に復活します（防具強化は解除）",color:"yellow"}
