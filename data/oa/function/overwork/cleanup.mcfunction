execute if entity @s[tag=oa.overwork_native] run effect clear @s minecraft:absorption
execute if entity @s[tag=oa.overwork_native] run effect clear @s minecraft:health_boost
execute if entity @s[tag=oa.overwork_native] run effect clear @s minecraft:regeneration
execute if entity @s[tag=oa.overwork_native] run effect clear @s minecraft:fire_resistance
execute if entity @s[tag=oa.overwork_crash] run effect clear @s minecraft:nausea
execute if entity @s[tag=oa.overwork_crash] run effect clear @s minecraft:slowness
scoreboard players set @s oa.owait 0
scoreboard players set @s oa.otime 0
tag @s remove oa.overwork_pending
tag @s remove oa.overwork_active
tag @s remove oa.overwork_crash
tag @s remove oa.overwork_native

execute if entity @s[tag=oa.yu_effects] run effect clear @s minecraft:poison
execute if entity @s[tag=oa.yu_effects] run effect clear @s minecraft:nausea
execute if entity @s[tag=oa.yu_effects] run effect clear @s minecraft:slowness
tag @s remove oa.yu_effects
