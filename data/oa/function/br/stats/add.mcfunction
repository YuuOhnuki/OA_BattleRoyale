scoreboard players add @s oa.t_games 1
scoreboard players operation @s oa.t_kill += @s br.st_kill
execute if entity @s[tag=br.winner] run scoreboard players add @s oa.t_win 1
