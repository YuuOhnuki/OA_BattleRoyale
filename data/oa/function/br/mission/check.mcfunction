execute if score @s br.mdone matches 1 run return 0
execute if score #mission br.tmp matches 1 if score @s br.st_open matches 8.. run return run function oa:br/mission/clear
execute if score #mission br.tmp matches 2 if score @s br.st_kill matches 1.. run return run function oa:br/mission/clear
execute if score #mission br.tmp matches 3 if score #time br.time matches 7200.. run return run function oa:br/mission/clear
execute if score #mission br.tmp matches 5 if score @s br.st_jmp matches 100.. run return run function oa:br/mission/clear
# 1.9.221：新しいお題（4 素手のキルは ach/new_kill、11 宝珠は disaster/relic/reward で判定）
execute if score #mission br.tmp matches 6 if score @s br.st_ore matches 5.. run return run function oa:br/mission/clear
# 与えたダメージは 1/10 HP 単位（♡×20 = 40HP = 400）
execute if score #mission br.tmp matches 7 if score @s br.st_dmg matches 400.. run return run function oa:br/mission/clear
execute if score #mission br.tmp matches 8 run function oa:br/mission/check_move
execute if score #mission br.tmp matches 9 if score @s br.st_kill matches 2.. run return run function oa:br/mission/clear
execute if score #mission br.tmp matches 10 if score #time br.time matches 10800.. run return run function oa:br/mission/clear
execute if score #mission br.tmp matches 12 if score @s br.st_open matches 15.. run return run function oa:br/mission/clear
