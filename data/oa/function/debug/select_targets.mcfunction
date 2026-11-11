tag @e[tag=oa.target] remove oa.target
execute if entity @s[tag=oa.db_mobs] run tag @e[tag=oa.debug_mob,distance=..48,nbt=!{Health:0.0f}] add oa.target
execute as @a[tag=oa.debug,tag=!oa.practice,tag=!oa.caster,gamemode=!spectator,distance=..48] run tag @s add oa.target
execute unless entity @s[tag=oa.db_friendly] as @e[tag=oa.target] if score #team oa.team matches 1.. if score @s oa.team = #team oa.team run tag @s remove oa.target
