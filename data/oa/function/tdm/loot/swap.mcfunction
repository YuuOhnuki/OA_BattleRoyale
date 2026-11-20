# Ground weapons change the current life only. Keep the pre-match choice in tdm.load.
scoreboard players operation #chosen tdm.sys = @s tdm.load
scoreboard players operation @s tdm.load = #pickup tdm.sys
clear @s *[minecraft:custom_data~{oa:{unique:1b}}]
function oa:internal/cleanup
scoreboard players set @s oa.owner 0
scoreboard players set @s oa.kind -1
execute if score @s tdm.load matches 1 run scoreboard players set #yuua_issued br.tmp 0
execute if score @s tdm.load matches 1 run tag @s add tdm.equip
execute if score @s tdm.load matches 1 run function oa:give/yuua
tag @s remove tdm.equip
execute unless score @s tdm.load matches 1 run function oa:tdm/equip
scoreboard players operation @s tdm.load = #chosen tdm.sys
title @s actionbar {text:"固有武器を交換しました（次の復活は選択画面の武器）",color:"gold"}
