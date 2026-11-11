advancement revoke @s only oa:itori/flins_hit
execute if entity @a[tag=oa.routed_damage] run return 0
execute if entity @s[tag=br.pvp_grace] run return 0
execute unless entity @s[tag=br.alive] run return 0
scoreboard players set #i_flins_hit oa.tmp 0
scoreboard players operation #i_victimteam oa.tmp = @s oa.team
execute on attacker if entity @s[scores={oa.i_flins=1..},tag=br.alive] if score @s oa.team matches 0 run scoreboard players set #i_flins_hit oa.tmp 1
execute on attacker if entity @s[scores={oa.i_flins=1..},tag=br.alive] unless score @s oa.team = #i_victimteam oa.tmp run scoreboard players set #i_flins_hit oa.tmp 1
execute unless score #i_flins_hit oa.tmp matches 1 run return 0
execute at @s run function oa:itori/zap
