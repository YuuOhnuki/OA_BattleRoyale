execute if block ~ ~ ~ minecraft:chest run return run function oa:br/loot/open_found
execute unless block ~ ~ ~ #minecraft:air unless block ~ ~ ~ minecraft:snow run return 0
scoreboard players add #open_ray br.tmp 1
execute if score #open_ray br.tmp matches ..24 positioned ^ ^ ^0.2 run function oa:br/loot/open_ray
