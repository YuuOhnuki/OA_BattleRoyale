execute if score #distance br.tmp matches ..-1 run scoreboard players operation #distance br.tmp *= #minus1 br.tmp
execute if score #distance br.tmp < @s br.edge run scoreboard players operation @s br.edge = #distance br.tmp
