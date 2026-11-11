execute unless score @s oa.born matches 0.. run scoreboard players operation @s oa.born = #total oa.gtime
scoreboard players operation #ground_age oa.tmp = #total oa.gtime
scoreboard players operation #ground_age oa.tmp -= @s oa.born
execute if score #ground_age oa.tmp matches 2400.. run kill @s
