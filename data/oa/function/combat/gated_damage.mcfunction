# Target executor, source is the unique synchronous oa.caster player.
scoreboard players set @s oa.blocked 0
execute if entity @a[tag=oa.caster,tag=oa.gacha_exposed] run return run scoreboard players set @s oa.blocked 1
execute unless entity @a[tag=oa.caster,tag=oa.db_free_grace] if entity @s[tag=br.pvp_grace] run return run scoreboard players set @s oa.blocked 1
execute unless entity @a[tag=oa.caster,limit=1] run return 0
execute if entity @s[tag=oa.self_decoy] run return run function oa:combat/decoy_intercept
execute if entity @s[tag=oa.decoy_grace] run return run scoreboard players set @s oa.blocked 1
execute if items entity @s armor.head *[minecraft:custom_data~{oa:{kind:5}}] run function oa:curse/roll
execute if score @s oa.blocked matches 1 run return 0
tag @s add oa.damage_target
execute as @a[tag=oa.caster,limit=1] at @s run function oa:combat/send_damage
tag @s remove oa.damage_target
