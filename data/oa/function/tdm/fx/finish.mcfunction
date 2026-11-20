scoreboard players set #win_fx tdm.sys 0
execute if score @s tdm.team matches 1 if score #red tdm.points > #blue tdm.points run scoreboard players set #win_fx tdm.sys 1
execute if score @s tdm.team matches 2 if score #blue tdm.points > #red tdm.points run scoreboard players set #win_fx tdm.sys 1
tag @s add tdm.fx_result
execute if score #win_fx tdm.sys matches 1 run tag @s add tdm.fx_win
