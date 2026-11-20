scoreboard players operation #delta tdm.sys = @s tdm.kills
scoreboard players operation #delta tdm.sys -= @s tdm.prev
scoreboard players operation @s tdm.prev = @s tdm.kills
execute unless score #delta tdm.sys matches 1.. run return 0
scoreboard players operation @s tdm.points += #delta tdm.sys
execute if score @s tdm.team matches 1 run scoreboard players operation #red tdm.points += #delta tdm.sys
execute if score @s tdm.team matches 2 run scoreboard players operation #blue tdm.points += #delta tdm.sys
scoreboard players set #arrow_reward tdm.sys 0
function oa:tdm/reward_arrows
playsound minecraft:entity.experience_orb.pickup player @s ~ ~ ~ 0.6 1.5
