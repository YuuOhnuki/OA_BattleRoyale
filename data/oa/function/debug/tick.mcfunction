execute unless entity @s[tag=br.admin] run return run function oa:debug/stop
execute unless score #state br.state matches 0 run return run function oa:debug/stop
execute unless score @s oa.db_seen = @s oa.left run return run function oa:debug/stop
execute if entity @s[nbt={Health:0.0f}] run return run function oa:debug/stop
execute if entity @s[tag=oa.db_free_cd] run scoreboard players set @s oa.cd 0
execute if entity @s[tag=oa.db_mobs] at @s as @e[type=#oa:arena_mobs,tag=!oa.lobby_exhibit,tag=!oa.debug_mob,distance=..48,nbt=!{Invulnerable:1b},nbt=!{Health:0.0f}] run function oa:debug/mob/init
function oa:debug/items_tick

execute if entity @s[tag=oa.db_infinite,gamemode=!creative] if score @s oa.db_snow matches 1.. run function oa:debug/refund_snow
execute if entity @s[tag=oa.db_infinite,gamemode=!creative] if score @s oa.db_egg matches 1.. run function oa:debug/refund_egg
scoreboard players set @s oa.db_snow 0
scoreboard players set @s oa.db_egg 0
