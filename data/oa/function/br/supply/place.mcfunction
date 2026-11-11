kill @e[type=minecraft:marker,tag=br.supply_new]
$summon minecraft:marker $(x) $(y) $(z) {Tags:["br.supply_new"]}
$execute store success score #ok br.flag run spreadplayers $(x) $(z) 0 $(range) false @e[tag=br.supply_new]
execute if score #ok br.flag matches 0 run kill @e[type=minecraft:marker,tag=br.supply_new]
execute if score #ok br.flag matches 1 as @e[type=minecraft:marker,tag=br.supply_new,limit=1] at @s run function oa:br/supply/preview
