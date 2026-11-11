execute unless score #state br.state matches 1 run return run function oa:br/mining/reset_if_spent
execute unless score @s br.round = #round br.round run function oa:br/mining/new_round
execute if score @s br.regen matches 1.. if score #time br.time >= @s br.regen run function oa:br/mining/restore
execute if score @s br.regen matches 1.. run return 0
execute if block ~ ~1 ~ minecraft:snow run setblock ~ ~1 ~ minecraft:air
execute if block ~ ~ ~ #minecraft:air run function oa:br/mining/broken
