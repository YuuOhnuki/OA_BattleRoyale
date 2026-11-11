execute if entity @s[tag=oa.gacha_exposed] run return 0
execute if entity @s[tag=oa.debug,tag=!oa.db_free_match] unless score #state br.state matches 1 run return 0
execute if entity @s[tag=oa.debug,tag=!oa.db_free_match,tag=!br.alive] run return 0
execute unless entity @s[tag=oa.db_free_grace] if entity @s[tag=br.pvp_grace] if score @s oa.kind matches 3 run return run function oa:combat/protection_notice
execute unless entity @s[tag=oa.db_free_grace] if entity @s[tag=br.pvp_grace] if score @s oa.kind matches 6 run return run function oa:combat/protection_notice
execute if entity @s[tag=oa.self_decoy] run return 0
execute if entity @s[tag=oa.decoy_grace] run return 0
execute if score @s oa.kind matches 3 run function oa:lazi/interval
execute if score @s oa.kind matches 4 if predicate oa:sneaking run return run function oa:nero/decoy
execute if score @s oa.kind matches 4 run function oa:nero/mark_or_return
execute if score @s oa.kind matches 6 run function oa:yuttari/use
execute if score @s oa.kind matches 7 run function oa:hotchikisu/use
execute if score @s oa.kind matches 8 run function oa:komame/use

execute if score @s oa.kind matches 9 run function oa:tayayuyu/use

execute if score @s oa.kind matches 10 run function oa:itori/use
