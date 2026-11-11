execute if entity @s[tag=oa.itori_windup] run return 0
execute unless score @s oa.kind matches 10 run return 0
execute unless items entity @s weapon.mainhand *[minecraft:custom_data~{oa:{kind:10}}] run return 0
execute unless entity @s[tag=br.alive] unless entity @s[tag=oa.db_free_match] run return 0
execute unless entity @s[tag=oa.db_free_match] unless score #state br.state matches 1 run return 0
execute if entity @s[tag=oa.gacha_exposed] run return 0
execute unless entity @s[tag=oa.db_free_grace] if entity @s[tag=br.pvp_grace] run return 0
execute if score @s oa.i_charge matches 15.. run function oa:itori/bolt_spawn
scoreboard players set @s oa.i_charge 0
