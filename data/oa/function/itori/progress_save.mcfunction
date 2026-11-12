# 練習場に入る前の昭心の進行度を退避する（練習中は全段階を解放するため、元の値を壊さない）
execute if score @s oa.ib_set matches 1 run return 0
execute unless score @s oa.i_round = #round br.round run return run scoreboard players set @s oa.ib_set 0
scoreboard players set @s oa.ib_set 1
scoreboard players operation @s oa.ib_pts = @s oa.i_points
scoreboard players operation @s oa.ib_ore = @s oa.i_ore
scoreboard players operation @s oa.ib_chest = @s oa.i_chest
scoreboard players operation @s oa.ib_round = @s oa.i_round
