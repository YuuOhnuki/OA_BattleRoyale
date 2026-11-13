$summon minecraft:marker $(x) $(y) $(z) {Tags:["br.dis","br.gm_new"]}
$execute store success score #ok br.flag run spreadplayers $(x) $(z) 0 $(range) false @e[type=minecraft:marker,tag=br.gm_new]
execute if score #ok br.flag matches 1 as @e[type=minecraft:marker,tag=br.gm_new] at @s run function oa:disaster/gimmick/surface
kill @e[type=minecraft:marker,tag=br.gm_new]
