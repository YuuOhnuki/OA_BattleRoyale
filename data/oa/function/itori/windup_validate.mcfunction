execute unless score @s br.round = #round br.round run return run kill @s
scoreboard players operation #i_windowner oa.tmp = @s oa.owner
scoreboard players set #i_windlive oa.tmp 0
execute as @a[tag=oa.itori_windup,distance=..4] if score @s oa.id = #i_windowner oa.tmp run scoreboard players set #i_windlive oa.tmp 1
execute unless score #i_windlive oa.tmp matches 1 run kill @s
