scoreboard players set @s oa.death 0
execute if score @s tdm.wait matches 1.. run return 0
execute at @s run function oa:tdm/fx/death
tag @s remove br.alive
function oa:tdm/clean_player
function oa:br/clear_inventory
scoreboard players set @s tdm.wait 200
scoreboard players set @s tdm.guard 0
scoreboard players set @s tdm.armor 0
tag @s add br.pvp_grace
execute unless entity @s[tag=oa.dead] run gamemode spectator @s
scoreboard players set @s tdm.ui 1
execute unless entity @s[tag=oa.dead] run function oa:tdm/wait_tick
title @s actionbar {text:"10秒後に復活。画面で次の固有武器を選択してください",color:"yellow"}
