execute if score @s oa.i_ver matches 1932 run return 0
execute if score @s oa.i_next matches 5.. run scoreboard players remove @s oa.i_next 1
execute if score @s oa.i_cycle matches 4.. run scoreboard players remove @s oa.i_cycle 1
execute if score @s oa.i_cycle matches 5.. run scoreboard players set @s oa.i_cycle 4
execute if score @s oa.i_next > @s oa.i_cycle run scoreboard players set @s oa.i_next 1
scoreboard players set @s oa.i_leap 0
execute if score @s oa.i_unlock matches 5.. run scoreboard players set @s oa.i_unlock 4
scoreboard players set @s oa.i_ver 1932
