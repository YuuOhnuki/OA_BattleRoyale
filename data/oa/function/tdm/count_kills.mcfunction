scoreboard players operation #delta tdm.sys = @s tdm.kills
scoreboard players operation #delta tdm.sys -= @s tdm.prev
scoreboard players operation @s tdm.prev = @s tdm.kills
execute unless score #delta tdm.sys matches 1.. run return 0
scoreboard players operation @s tdm.points += #delta tdm.sys
execute if score @s tdm.team matches 1 run scoreboard players operation #red tdm.points += #delta tdm.sys
execute if score @s tdm.team matches 2 run scoreboard players operation #blue tdm.points += #delta tdm.sys
effect give @s minecraft:regeneration 5 3 true
effect give @s minecraft:speed 5 1 true
scoreboard players operation #food_reward tdm.sys = #delta tdm.sys
scoreboard players set #four tdm.sys 4
scoreboard players operation #food_reward tdm.sys *= #four tdm.sys
scoreboard players operation @s tdm.food += #food_reward tdm.sys
execute at @s run function oa:tdm/fx/kill
function oa:tdm/reward_arrows
