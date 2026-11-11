execute if entity @s[tag=oa.gacha_exposed] run return 0
# One shared 4-second cooldown for both outcomes (automatic and manual).
execute if entity @s[tag=oa.debug,tag=!oa.db_free_match] unless score #state br.state matches 1 run return 0
execute if entity @s[tag=oa.debug,tag=!oa.db_free_match,tag=!br.alive] run return 0
execute unless entity @s[tag=oa.db_free_grace] if entity @s[tag=br.pvp_grace] run return 0
execute unless entity @s[tag=oa.db_free_cd] if score @s oa.cd matches 1.. run return 0
scoreboard players set @s oa.cd 80
execute store result score #breath_roll oa.tmp run random value 1..100
execute if score #breath_roll oa.tmp matches 1..40 run return run function oa:lazi/out_of_breath
function oa:lazi/sonic
