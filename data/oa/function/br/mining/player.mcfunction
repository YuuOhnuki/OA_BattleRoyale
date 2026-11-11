execute unless items entity @s weapon.mainhand *[minecraft:custom_data~{br_pick:1b}] run return 0
scoreboard players set #allow br.flag 0
scoreboard players set #ray br.ray 0
execute at @s rotated as @s anchored eyes positioned ^ ^ ^0.2 anchored feet run function oa:br/mining/ray
execute if score #allow br.flag matches 1 run item modify entity @s weapon.mainhand oa:miner_enable
execute if score #allow br.flag matches 1 run tag @s add br.mining_allowed
execute if score #allow br.flag matches 0 run item modify entity @s weapon.mainhand oa:miner_disable
execute if score #allow br.flag matches 0 run tag @s remove br.mining_allowed
