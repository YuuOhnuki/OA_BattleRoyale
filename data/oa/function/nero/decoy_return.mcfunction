execute unless entity @s[tag=oa.self_decoy] run return 0
function oa:nero/end_fx
tag @s remove oa.self_decoy
# Preserve guard until next tick; same attack's enchantments are evaluated after hurt events.
tag @s add oa.decoy_grace
scoreboard players set @s oa.decoy 0
execute store result storage oa:args id int 1 run scoreboard players get @s oa.id
function oa:nero/load_decoy with storage oa:args
playsound minecraft:entity.enderman.teleport player @s ~ ~ ~ 1.2 0.65
execute if data storage oa:position value.dim run function oa:internal/tp with storage oa:position value
execute at @s run playsound minecraft:entity.enderman.teleport player @s ~ ~ ~ 1.08 1.4
execute at @s run function oa:nero/end_fx
function oa:nero/clear_decoy with storage oa:args
