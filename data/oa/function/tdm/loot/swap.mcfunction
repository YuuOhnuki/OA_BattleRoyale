# Ground weapons change the current life only. Keep the pre-match choice in tdm.load.
scoreboard players operation #chosen tdm.sys = @s tdm.load
scoreboard players set #swap_ok tdm.sys 0
scoreboard players operation @s tdm.load = #pickup tdm.sys
function oa:tdm/loot/drop_old
execute unless score #drop_ok tdm.sys matches 1 run scoreboard players operation @s tdm.load = #chosen tdm.sys
execute unless score #drop_ok tdm.sys matches 1 run return 0
clear @s *[minecraft:custom_data~{oa:{unique:1b}}]
function oa:internal/cleanup
scoreboard players set @s oa.owner 0
scoreboard players set @s oa.kind -1
execute unless entity @e[tag=tdm.claim,tag=tdm.saved] if score @s tdm.load matches 1 run scoreboard players set #yuua_issued br.tmp 0
execute unless entity @e[tag=tdm.claim,tag=tdm.saved] if score @s tdm.load matches 1 run tag @s add tdm.equip
execute unless entity @e[tag=tdm.claim,tag=tdm.saved] if score @s tdm.load matches 1 run function oa:give/yuua
tag @s remove tdm.equip
execute unless entity @e[tag=tdm.claim,tag=tdm.saved] unless score @s tdm.load matches 1 run function oa:tdm/equip
execute if entity @e[tag=tdm.claim,tag=tdm.saved] run item replace entity @s hotbar.0 from entity @e[tag=tdm.claim,limit=1] contents
tag @s add tdm.swap_latched
scoreboard players set #swap_ok tdm.sys 1
scoreboard players operation @s tdm.load = #chosen tdm.sys
title @s actionbar {text:"固有武器を交換しました（次の復活は選択画面の武器）",color:"gold"}
