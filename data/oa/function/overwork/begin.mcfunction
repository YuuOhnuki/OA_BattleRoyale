tag @s remove oa.overwork_pending
tag @s remove oa.overwork_crash
tag @s add oa.overwork_active
scoreboard players set @s oa.otime 200
effect give @s minecraft:absorption 5 1 true
effect give @s minecraft:health_boost 5 1 true
playsound minecraft:item.totem.use player @a[distance=..48] ~ ~ ~ 3 0.8
playsound minecraft:entity.ender_dragon.growl player @a[distance=..32] ~ ~ ~ 1.5 1.6
particle minecraft:totem_of_undying ~ ~1 ~ 0.7 0.9 0.7 0.35 90 normal @a[distance=..32]
particle minecraft:firework ~ ~1 ~ 0.5 0.6 0.5 0.12 40 normal @a[distance=..32]

effect give @s minecraft:poison 10 0 true
effect give @s minecraft:nausea 10 0 true

tag @s add oa.yu_effects
