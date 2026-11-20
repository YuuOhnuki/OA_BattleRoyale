scoreboard players set @s tdm.team 2
execute if score #red_n tdm.sys <= #blue_n tdm.sys run scoreboard players set @s tdm.team 1
execute if score @s tdm.team matches 1 run scoreboard players add #red_n tdm.sys 1
execute if score @s tdm.team matches 2 run scoreboard players add #blue_n tdm.sys 1
