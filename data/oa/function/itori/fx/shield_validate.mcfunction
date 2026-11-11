execute unless score @s br.round = #round br.round run return run kill @s
scoreboard players operation #i_shield_owner oa.tmp = @s oa.owner
scoreboard players set #i_shield_live oa.tmp 0
execute as @a[tag=oa.itori_shield,scores={oa.i_shield=1..},distance=..8] if score @s oa.id = #i_shield_owner oa.tmp run scoreboard players set #i_shield_live oa.tmp 1
execute unless score #i_shield_live oa.tmp matches 1 run kill @s
