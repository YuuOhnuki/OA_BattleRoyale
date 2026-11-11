# Apply team/grace exclusions to the radial native knockback as well as damage.
scoreboard players operation #native_owner oa.tmp = @s oa.fowner
scoreboard players operation #native_team oa.tmp = @s oa.fteam
tag @a remove oa.furo_guard
execute if score #native_team oa.tmp matches 1.. as @a unless score @s oa.id = #native_owner oa.tmp if score @s oa.team = #native_team oa.tmp run tag @s add oa.furo_guard
tag @a[tag=br.pvp_grace] add oa.furo_guard
tag @a[gamemode=spectator] add oa.furo_guard
execute as @a[tag=oa.furo_guard] run attribute @s minecraft:explosion_knockback_resistance modifier add oa:furo_guard 1 add_value
