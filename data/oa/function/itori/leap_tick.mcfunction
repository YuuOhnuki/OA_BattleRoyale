execute store result score #i_scale oa.tmp run attribute @s minecraft:scale get 1000
execute if score #i_scale oa.tmp matches 1001.. run return run scoreboard players set @s oa.i_leap 0
execute store result storage oa:itori step int 1 run scoreboard players get @s oa.i_leap
function oa:itori/leap_dispatch with storage oa:itori
scoreboard players remove @s[scores={oa.i_leap=1..}] oa.i_leap 1

particle minecraft:dust{color:[1.0,0.5,0.04],scale:1.2} ~ ~0.2 ~ 0.15 0.08 0.15 0.01 4 normal @a[distance=..24]
particle minecraft:crit ~ ~0.15 ~ 0.15 0.08 0.15 0.02 2 normal @a[distance=..24]
