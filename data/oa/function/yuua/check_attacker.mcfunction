advancement revoke @s only oa:yuua/struck
execute if entity @s[tag=br.pvp_grace] run return 0
execute if entity @s[tag=oa.self_decoy] run return 0
execute if entity @s[tag=oa.decoy_grace] run return 0
scoreboard players set @s oa.blocked 0
execute if items entity @s armor.head *[minecraft:custom_data~{oa:{kind:5}}] run function oa:curse/roll
execute if score @s oa.blocked matches 1 run return 0
tag @s add oa.hat_victim
execute on attacker if entity @s[tag=oa.player] if items entity @s armor.head *[minecraft:custom_data~{oa:{kind:1}}] at @s run function oa:yuua/strike
tag @s remove oa.hat_victim
