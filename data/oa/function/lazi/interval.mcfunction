execute if entity @s[tag=oa.gacha_exposed] run return 0
# One shared 4-second cooldown for both outcomes (automatic and manual).
execute if entity @s[tag=oa.debug,tag=!oa.db_free_match] unless score #state br.state matches 1 run return 0
execute if entity @s[tag=oa.debug,tag=!oa.db_free_match,tag=!br.alive] run return 0
execute unless entity @s[tag=oa.db_free_grace] if entity @s[tag=br.pvp_grace] run return 0
execute unless entity @s[tag=oa.db_free_cd] if score @s oa.cd matches 1.. run return 0
scoreboard players set @s oa.cd 80
execute store result score #breath_roll oa.tmp run random value 1..100
# 1.9.175: 息切れ25%・攻撃75%。攻撃が4回続いたら、次は必ず息切れ（連続回数 oa.lzn、息切れで0に戻す）
execute if score @s oa.lzn matches 4.. run return run function oa:lazi/out_of_breath
execute if score #breath_roll oa.tmp matches 1..25 run return run function oa:lazi/out_of_breath
scoreboard players add @s oa.lzn 1
function oa:lazi/sonic
