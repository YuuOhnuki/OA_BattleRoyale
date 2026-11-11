execute if score @s oa.root matches 1.. run return run scoreboard players set @s oa.tpush 0
execute unless entity @s[tag=oa.db_free_match] unless entity @s[tag=oa.debug_mob] unless entity @s[tag=br.alive,gamemode=!spectator,tag=!oa.self_decoy,tag=!oa.decoy_grace,tag=!br.pvp_grace] run return run scoreboard players set @s oa.tpush 0
execute if data entity @s RootVehicle run return run scoreboard players set @s oa.tpush 0
execute unless entity @s[tag=oa.db_free_match] unless entity @s[tag=oa.debug_mob] unless score #state br.state matches 1 run return run scoreboard players set @s oa.tpush 0
execute store result storage oa:throw_push args.id int 1 run scoreboard players get @s oa.id
function oa:throwable/push/load with storage oa:throw_push args
function oa:throwable/push/step with storage oa:throw_push args
scoreboard players remove @s oa.tpush 1
