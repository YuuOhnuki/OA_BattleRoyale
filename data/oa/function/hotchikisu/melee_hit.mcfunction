execute if entity @s[tag=br.pvp_grace] run return 0
execute if entity @s[tag=oa.self_decoy] run return 0
execute if entity @s[tag=oa.decoy_grace] run return 0
scoreboard players set @s oa.bleed 40
execute on attacker run scoreboard players operation #stapler oa.id = @s oa.id
scoreboard players operation @s oa.bleed_by = #stapler oa.id
