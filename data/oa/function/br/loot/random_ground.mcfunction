execute store result score #spawn_roll br.tmp run random value 1..20
execute if score #spawn_roll br.tmp matches 1 run return 0
$summon minecraft:marker $(x) $(y) $(z) {Tags:["br.ground_new"]}
$execute store success score #ok br.flag run spreadplayers $(x) $(z) 0 $(range) false @e[tag=br.ground_new]
execute if score #ok br.flag matches 1 as @e[tag=br.ground_new] at @s run function oa:br/loot/ground_surface
kill @e[tag=br.ground_new]
