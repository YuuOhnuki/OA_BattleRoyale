# 練習場から出るとき、入場前の昭心の進行度を戻す（退避が無ければ通常のリセット結果のまま）
execute unless score @s oa.ib_set matches 1 run return 0
scoreboard players set @s oa.ib_set 0
execute unless score @s oa.ib_round = #round br.round run return 0
scoreboard players operation @s oa.i_points = @s oa.ib_pts
scoreboard players operation @s oa.i_ore = @s oa.ib_ore
scoreboard players operation @s oa.i_chest = @s oa.ib_chest
scoreboard players set @s oa.i_unlock 1
execute if score @s oa.i_points matches 1.. run scoreboard players set @s oa.i_unlock 2
execute if score @s oa.i_points matches 5.. run scoreboard players set @s oa.i_unlock 3
execute if score @s oa.i_points matches 7.. run scoreboard players set @s oa.i_unlock 4
execute if score @s oa.i_points matches 10.. run scoreboard players set @s oa.i_unlock 5
execute if score @s oa.i_points matches 15.. run scoreboard players set @s oa.i_unlock 6
