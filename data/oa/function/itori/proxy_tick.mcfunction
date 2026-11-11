scoreboard players operation #i_owner oa.tmp = @s oa.owner
scoreboard players set #i_valid oa.tmp 0
execute as @a[tag=br.alive,scores={oa.kind=10},distance=..4] if score @s oa.id = #i_owner oa.tmp if items entity @s weapon.mainhand *[minecraft:custom_data~{oa:{kind:10}}] run scoreboard players set #i_valid oa.tmp 1
execute as @a[tag=oa.db_free_match,scores={oa.kind=10},distance=..4] if score @s oa.id = #i_owner oa.tmp if items entity @s weapon.mainhand *[minecraft:custom_data~{oa:{kind:10}}] run scoreboard players set #i_valid oa.tmp 1
execute unless score #i_valid oa.tmp matches 1 run return run kill @s
execute if data entity @s attack on attacker if score @s oa.id = #i_owner oa.tmp at @s run function oa:itori/attack
execute if data entity @s interaction on target if score @s oa.id = #i_owner oa.tmp at @s run function oa:itori/use
data remove entity @s attack
data remove entity @s interaction
