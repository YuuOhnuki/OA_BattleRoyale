execute unless data entity @s data.velocity run return 0
tag @a remove oa.observe_owner
scoreboard players operation #obs_owner oa.tmp = @s oa.powner
execute as @a[tag=br.alive,tag=!br.pvp_grace] if score @s oa.id = #obs_owner oa.tmp run tag @s add oa.observe_owner
execute as @a[tag=oa.debug,tag=oa.db_free_match] if score @s oa.id = #obs_owner oa.tmp run tag @s add oa.observe_owner
execute unless entity @a[tag=oa.observe_owner] run return 0
scoreboard players operation #obs_team oa.team = @a[tag=oa.observe_owner,limit=1] oa.team
scoreboard players set #obs_snow oa.tmp 0
execute if entity @s[tag=oa.observe_snow] run scoreboard players set #obs_snow oa.tmp 1
scoreboard players set #hit oa.tmp 0
scoreboard players set #ray oa.tmp 20
scoreboard players set #twenty oa.tmp 20
execute store result score #mx oa.tmp run data get entity @s data.velocity[0] 10000
execute store result score #my oa.tmp run data get entity @s data.velocity[1] 10000
execute store result score #mz oa.tmp run data get entity @s data.velocity[2] 10000
scoreboard players operation #mx oa.tmp /= #twenty oa.tmp
scoreboard players operation #my oa.tmp /= #twenty oa.tmp
scoreboard players operation #mz oa.tmp /= #twenty oa.tmp
execute store result storage oa:throw_step x double 0.0001 run scoreboard players get #mx oa.tmp
execute store result storage oa:throw_step y double 0.0001 run scoreboard players get #my oa.tmp
execute store result storage oa:throw_step z double 0.0001 run scoreboard players get #mz oa.tmp
function oa:throwable/observe/ray
tag @a remove oa.observe_owner
