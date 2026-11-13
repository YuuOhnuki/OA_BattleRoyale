execute if entity @s[nbt={Health:0.0f}] run return run scoreboard players set @s oa.kpush 0
execute if entity @s[gamemode=spectator] run return run scoreboard players set @s oa.kpush 0
execute if entity @s[tag=oa.self_decoy] run return run scoreboard players set @s oa.kpush 0
execute if entity @s[tag=oa.decoy_grace] run return run scoreboard players set @s oa.kpush 0
execute if data entity @s RootVehicle run return run scoreboard players set @s oa.kpush 0
execute store result storage oa:kb id int 1 run scoreboard players get @s oa.id
function oa:knockback/load with storage oa:kb
function oa:knockback/step with storage oa:kb
execute if score @s oa.kpush matches 1.. if score @s oa.kboost matches 1.. run function oa:knockback/step with storage oa:kb
execute if score @s oa.kpush matches 1.. if score @s oa.kboost matches 2.. run function oa:knockback/step with storage oa:kb
execute if score @s oa.kpush matches 1.. if score @s oa.kboost matches 2.. run function oa:knockback/step with storage oa:kb
scoreboard players remove @s[scores={oa.kpush=1..}] oa.kpush 1
