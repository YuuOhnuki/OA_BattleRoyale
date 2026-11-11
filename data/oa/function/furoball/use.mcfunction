advancement revoke @s only oa:furoball/use
execute if entity @s[tag=oa.gacha_exposed] run return run function oa:furoball/unavailable
execute unless entity @s[tag=oa.db_free_match] unless score #state br.state matches 1 run return run function oa:furoball/unavailable
execute unless entity @s[tag=oa.db_free_match] unless entity @s[tag=br.alive,gamemode=!spectator] run return run function oa:furoball/unavailable
execute unless entity @s[tag=oa.db_free_grace] if entity @s[tag=br.pvp_grace] run return run function oa:furoball/protected
execute if entity @s[tag=oa.self_decoy] run return run function oa:furoball/unavailable
execute if entity @s[tag=oa.decoy_grace] run return run function oa:furoball/unavailable
scoreboard players set #f_count oa.tmp 0
execute as @e[type=minecraft:item_display,tag=oa.furoball] run scoreboard players add #f_count oa.tmp 1
execute if score #f_count oa.tmp matches 20.. run return run function oa:furoball/unavailable
scoreboard players operation #f_owner oa.tmp = @s oa.id
scoreboard players operation #f_team oa.tmp = @s oa.team
execute anchored eyes positioned ^ ^ ^0.5 run function oa:furoball/spawn
playsound minecraft:item.firecharge.use player @a[distance=..24] ~ ~ ~ 1.4 0.8
