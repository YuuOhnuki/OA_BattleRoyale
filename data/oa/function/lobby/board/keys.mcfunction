function oa:br/stats/count_ach
scoreboard players operation @s oa.t_rank = @s oa.t_win
scoreboard players operation @s oa.t_rank *= #10000 oa.tmp
scoreboard players operation @s oa.t_rank += @s oa.t_kill
