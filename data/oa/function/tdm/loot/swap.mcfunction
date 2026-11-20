# Ground weapons change the current life only. Keep the pre-match choice in tdm.load.
scoreboard players operation #chosen tdm.sys = @s tdm.load
scoreboard players operation @s tdm.load = #pickup tdm.sys
clear @s *[minecraft:custom_data~{oa:{unique:1b}}]
function oa:internal/cleanup
scoreboard players set @s oa.owner 0
scoreboard players set @s oa.kind -1
function oa:tdm/equip
scoreboard players operation @s tdm.load = #chosen tdm.sys
title @s actionbar {text:"固有武器を交換しました（次の復活では初期武器）",color:"gold"}
