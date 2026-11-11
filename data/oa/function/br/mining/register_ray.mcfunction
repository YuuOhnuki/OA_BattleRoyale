execute align xyz positioned ~0.5 ~0.5 ~0.5 run function oa:br/mining/internal/register_block
execute if score #registered br.flag matches 1 run return 0
execute unless block ~ ~ ~ #minecraft:air unless block ~ ~ ~ minecraft:water run return 0
scoreboard players add #ray br.ray 1
execute if score #ray br.ray matches ..60 positioned ^ ^ ^0.1 run function oa:br/mining/register_ray
