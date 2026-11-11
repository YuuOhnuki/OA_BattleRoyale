execute align xyz positioned ~0.5 ~0.5 ~0.5 if entity @e[tag=br.ore,scores={br.regen=0},distance=..0.1] run scoreboard players set #allow br.flag 1
execute if score #allow br.flag matches 1 run return 0
execute unless block ~ ~ ~ #minecraft:air unless block ~ ~ ~ minecraft:snow run return 0
scoreboard players add #ray br.ray 1
execute if score #ray br.ray matches ..19 positioned ^ ^ ^0.3 run function oa:br/mining/ray
