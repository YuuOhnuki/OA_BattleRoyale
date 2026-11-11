advancement revoke @s only oa:nero/decoy_hit
execute if entity @s[tag=br.pvp_grace] run return 0
execute unless entity @s[tag=oa.self_decoy] run return 0
function oa:nero/pop
# Damage event updates the responsible attacker before granting this advancement.
execute on attacker if entity @s[type=minecraft:player] at @s run function oa:nero/blind_attacker
function oa:nero/decoy_return

execute on attacker if entity @s[tag=oa.debug_mob] at @s run function oa:nero/blind_attacker
