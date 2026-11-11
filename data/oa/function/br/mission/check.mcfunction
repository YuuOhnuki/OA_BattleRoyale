execute if score @s br.mdone matches 1 run return 0
execute if score #mission br.tmp matches 1 if score @s br.st_open matches 8.. run function oa:br/mission/clear
execute if score #mission br.tmp matches 2 if score @s br.st_kill matches 1.. run function oa:br/mission/clear
execute if score #mission br.tmp matches 3 if score #time br.time matches 7200.. run function oa:br/mission/clear
execute if score #mission br.tmp matches 5 if score @s br.st_jmp matches 100.. run function oa:br/mission/clear
