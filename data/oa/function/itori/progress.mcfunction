execute if entity @s[tag=oa.practice] run scoreboard players set @s oa.i_points 15
execute if entity @s[tag=oa.practice] run return run scoreboard players set @s oa.i_unlock 6
execute unless score @s oa.i_round = #round br.round run function oa:itori/progress_reset
execute unless score @s oa.i_ver matches 1932 run function oa:itori/migrate1932
execute unless entity @s[tag=br.alive] unless entity @s[tag=oa.debug] run return 0
scoreboard players add @s oa.i_points 0
scoreboard players operation #i_before oa.tmp = @s oa.i_unlock
scoreboard players set @s oa.i_unlock 1
execute if score @s oa.i_points matches 1.. run scoreboard players set @s oa.i_unlock 2
execute if score @s oa.i_points matches 5.. run scoreboard players set @s oa.i_unlock 3
execute if score @s oa.i_points matches 7.. run scoreboard players set @s oa.i_unlock 4
execute if score @s oa.i_points matches 10.. run scoreboard players set @s oa.i_unlock 5
execute if score @s oa.i_points matches 15.. run scoreboard players set @s oa.i_unlock 6
execute if score @s oa.i_unlock > #i_before oa.tmp at @s run function oa:itori/unlock_notice
