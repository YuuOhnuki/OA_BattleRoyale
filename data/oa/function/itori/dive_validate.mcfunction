scoreboard players operation #i_diver oa.tmp = @s oa.owner
scoreboard players set #i_diver_live oa.tmp 0
execute as @a[scores={oa.i_dive=1..}] if score @s oa.id = #i_diver oa.tmp run scoreboard players set #i_diver_live oa.tmp 1
execute unless score #i_diver_live oa.tmp matches 1 run kill @s
