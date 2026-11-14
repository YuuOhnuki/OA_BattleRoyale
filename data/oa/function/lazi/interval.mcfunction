execute if entity @s[tag=oa.gacha_exposed] run return 0
# One shared 2-second cooldown for both outcomes (automatic and manual).
execute if entity @s[tag=oa.debug,tag=!oa.db_free_match] unless score #state br.state matches 1 run return 0
execute if entity @s[tag=oa.debug,tag=!oa.db_free_match,tag=!br.alive] run return 0
execute unless entity @s[tag=oa.db_free_grace] if entity @s[tag=br.pvp_grace] run return 0
execute unless entity @s[tag=oa.db_free_cd] if score @s oa.cd matches 1.. run return 0
scoreboard players set @s oa.cd 40
execute store result score #breath_roll oa.tmp run random value 1..100
# 1.9.176: 2秒ごと、息切れ30%・攻撃70%（1.9.175 の「攻撃4連続の次は息切れ」は廃止）
execute if score #breath_roll oa.tmp matches 1..30 run return run function oa:lazi/out_of_breath
function oa:lazi/sonic
