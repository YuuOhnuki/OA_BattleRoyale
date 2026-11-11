execute unless score #state br.state matches 0 run return 0
execute unless entity @s[tag=br.lobby,tag=!br.playing,tag=!oa.practice,scores={br.pick=1..10}] run return 0
execute if score @s br.pick matches 1 unless entity @s[team=oa_br1] run team join oa_br1 @s
execute if score @s br.pick matches 2 unless entity @s[team=oa_br2] run team join oa_br2 @s
execute if score @s br.pick matches 3 unless entity @s[team=oa_br3] run team join oa_br3 @s
execute if score @s br.pick matches 4 unless entity @s[team=oa_br4] run team join oa_br4 @s
execute if score @s br.pick matches 5 unless entity @s[team=oa_br5] run team join oa_br5 @s
execute if score @s br.pick matches 6 unless entity @s[team=oa_br6] run team join oa_br6 @s
execute if score @s br.pick matches 7 unless entity @s[team=oa_br7] run team join oa_br7 @s
execute if score @s br.pick matches 8 unless entity @s[team=oa_br8] run team join oa_br8 @s
execute if score @s br.pick matches 9 unless entity @s[team=oa_br9] run team join oa_br9 @s
execute if score @s br.pick matches 10 unless entity @s[team=oa_br10] run team join oa_br10 @s
