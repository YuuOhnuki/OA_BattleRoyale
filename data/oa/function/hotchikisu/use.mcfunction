execute if entity @s[tag=oa.gacha_exposed] run return 0
execute if entity @s[tag=oa.debug,tag=!oa.db_free_match] unless score #state br.state matches 1 run return 0
execute if entity @s[tag=oa.debug,tag=!oa.db_free_match,tag=!br.alive] run return 0
execute unless entity @s[tag=oa.db_free_grace] if entity @s[tag=br.pvp_grace] run return run function oa:combat/protection_notice
execute if entity @s[tag=oa.self_decoy] run return 0
execute if entity @s[tag=oa.decoy_grace] run return 0
execute unless score @s oa.kind matches 7 run return 0
execute unless entity @s[tag=oa.db_free_cd] if score @s oa.cd matches 1.. run return 0
scoreboard players set @s oa.cd 300
function oa:combat/select_targets
function oa:hotchikisu/range_fx
playsound minecraft:block.anvil.land player @a[distance=..24] ~ ~ ~ 0.96 1.4
tag @a remove oa.staple_range
execute positioned ~ ~-1 ~ run tag @e[tag=oa.target,distance=..3] add oa.staple_range
execute positioned ~ ~1 ~ run tag @e[tag=oa.target,distance=..3] add oa.staple_range
tag @e[tag=oa.target,distance=..3] add oa.staple_range
execute as @e[tag=oa.staple_range,nbt=!{Health:0.0f}] at @s run function oa:hotchikisu/root_target
tag @a remove oa.staple_range
function oa:combat/finish

particle minecraft:firework ~ ~1 ~ 0.5 0.7 0.5 0.03 16 normal @a[distance=..24]
