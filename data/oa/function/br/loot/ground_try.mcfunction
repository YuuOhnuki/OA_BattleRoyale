$summon minecraft:marker $(x) $(y) $(z) {Tags:["br.ground_new"]}
$execute unless score #map oa.mapid matches 2..4 store success score #ok br.flag run spreadplayers $(x) $(z) 0 $(range) false @e[tag=br.ground_new]
# 1.9.230：天空島・異界は空中の島なので、上から床を探す（under 120）。島のない列では奈落に置かれるが ground_surface で外れる
$execute if score #map oa.mapid matches 3..4 store success score #ok br.flag run spreadplayers $(x) $(z) 0 $(range) under 120 false @e[tag=br.ground_new]
# 1.9.167: 洞窟は天井より下の床を探す（under 76）。岩だけの列では奈落に置かれるが、ground_surface の地面の判定で外れる
$execute if score #map oa.mapid matches 2 store success score #ok br.flag run spreadplayers $(x) $(z) 0 $(range) under 76 false @e[tag=br.ground_new]
execute if score #ok br.flag matches 1 as @e[tag=br.ground_new] at @s run function oa:br/loot/ground_surface
kill @e[tag=br.ground_new]
