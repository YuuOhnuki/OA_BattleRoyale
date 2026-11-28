execute if score @s br.mdone matches 1 run return 0
# 1.9.223：お題の判定（8 素手のキルは ach/new_kill で判定）。数値は br/mission/name の文言と合わせる
execute if score #mission br.tmp matches 1 if score @s br.st_open matches 10.. run return run function oa:br/mission/clear
execute if score #mission br.tmp matches 2 if score @s br.st_kill matches 1.. run return run function oa:br/mission/clear
execute if score #mission br.tmp matches 3 if score #time br.time matches 7200.. run return run function oa:br/mission/clear
execute if score #mission br.tmp matches 4 if score @s br.st_jmp matches 200.. run return run function oa:br/mission/clear
execute if score #mission br.tmp matches 5 run function oa:br/mission/check_move
execute if score #mission br.tmp matches 6 if score @s br.st_ore matches 10.. run return run function oa:br/mission/clear
# 与えたダメージは 1/10 HP 単位（♡×10 = 20HP = 200、♡×30 = 600）
execute if score #mission br.tmp matches 7 if score @s br.st_dmg matches 200.. run return run function oa:br/mission/clear
execute if score #mission br.tmp matches 9 if score @s br.st_relic matches 4.. run return run function oa:br/mission/clear
execute if score #mission br.tmp matches 10 if score @s br.st_open matches 20.. run return run function oa:br/mission/clear
execute if score #mission br.tmp matches 11 run function oa:br/mission/check_move
execute if score #mission br.tmp matches 12 if score @s br.st_dmg matches 600.. run return run function oa:br/mission/clear
# 1.9.261：お題13〜24（15・16 のキルは ach/new_kill で判定）
execute if score #mission br.tmp matches 13 if score @s br.st_kill matches 2.. run return run function oa:br/mission/clear
execute if score #mission br.tmp matches 14 if score @s br.st_kill matches 3.. run return run function oa:br/mission/clear
execute if score #mission br.tmp matches 17 if score @s br.st_open matches 15.. run return run function oa:br/mission/clear
execute if score #mission br.tmp matches 18 if score @s br.st_ore matches 20.. run return run function oa:br/mission/clear
execute if score #mission br.tmp matches 19 if score @s br.st_relic matches 2.. run return run function oa:br/mission/clear
execute if score #mission br.tmp matches 20 if score @s br.st_dmg matches 400.. run return run function oa:br/mission/clear
execute if score #mission br.tmp matches 21 if score #time br.time matches 10800.. run return run function oa:br/mission/clear
execute if score #mission br.tmp matches 22 run function oa:br/mission/check_last3
execute if score #mission br.tmp matches 23 if score @s br.st_jmp matches 300.. run return run function oa:br/mission/clear
execute if score #mission br.tmp matches 24 run function oa:br/mission/check_kinds
