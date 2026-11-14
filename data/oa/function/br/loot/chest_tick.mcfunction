execute unless block ~ ~ ~ minecraft:chest[type=single] run return 0
execute unless score @s br.round = #round br.round run function oa:br/loot/chest_initial
execute if score #time br.time matches 7200.. if score @s br.cstage matches 0 run function oa:br/loot/chest_upgrade
