execute if score #state br.state matches 1.. run return 0
execute at @s positioned ~ ~-0.2 ~ align xyz positioned ~0.5 ~0.5 ~0.5 as @e[tag=br.ore,distance=..0.2] run function oa:br/mining/remove
