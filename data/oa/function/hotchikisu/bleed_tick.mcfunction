particle minecraft:dust{color:[0.65,0.02,0.02],scale:0.8} ~ ~0.8 ~ 0.15 0.3 0.15 0 5 normal @a[distance=..24]
execute if entity @s[tag=br.pvp_grace] run return 0
execute if entity @s[tag=oa.self_decoy] run return 0
scoreboard players operation #bleeder oa.id = @s oa.bleed_by
tag @s add oa.bleed_target
execute as @a[tag=oa.player] if score @s oa.id = #bleeder oa.id run damage @e[tag=oa.bleed_target,limit=1] 0.5 oa:bleeding by @s
tag @s remove oa.bleed_target
