scoreboard players add #sup_try br.tmp 1
$execute store success score #sp_ok br.flag run spreadplayers $(x) $(z) 0 $(range) false @e[type=minecraft:marker,tag=br.supply_new]
execute if score #sp_ok br.flag matches 1 run scoreboard players set #ok br.flag 1
scoreboard players set #sup_good br.tmp 0
execute if score #sp_ok br.flag matches 1 as @e[type=minecraft:marker,tag=br.supply_new,limit=1] at @s run function oa:br/supply/ground_ok
execute if score #sup_good br.tmp matches 1 run return 1
execute if score #sup_try br.tmp matches 20.. run return 0
function oa:br/supply/place_try with storage oa:br_spawn
