scoreboard players add #sup_try br.tmp 1
$execute unless score #map oa.mapid matches 2..4 store success score #sp_ok br.flag run spreadplayers $(x) $(z) 0 $(range) false @e[type=minecraft:marker,tag=br.supply_new]
# 1.9.230：天空都市・異界は上から床を探す（under 120）。島のない列では奈落に置かれるので ground_ok で落とす
$execute if score #map oa.mapid matches 3..4 store success score #sp_ok br.flag run spreadplayers $(x) $(z) 0 $(range) under 120 false @e[type=minecraft:marker,tag=br.supply_new]
# 1.9.167: 洞窟は天井より下の床を探す（under 76）。岩だけの列では奈落に置かれるので ground_ok で落とす
$execute if score #map oa.mapid matches 2 store success score #sp_ok br.flag run spreadplayers $(x) $(z) 0 $(range) under 76 false @e[type=minecraft:marker,tag=br.supply_new]
execute if score #sp_ok br.flag matches 1 run scoreboard players set #ok br.flag 1
scoreboard players set #sup_good br.tmp 0
execute if score #sp_ok br.flag matches 1 as @e[type=minecraft:marker,tag=br.supply_new,limit=1] at @s run function oa:br/supply/ground_ok
# 1.9.186: 中心に近すぎる場所は選び直す
execute if score #sup_good br.tmp matches 1 as @e[type=minecraft:marker,tag=br.supply_new,limit=1] run function oa:br/supply/far_check
execute if score #sup_good br.tmp matches 1 run return 1
execute if score #sup_try br.tmp matches 20.. unless score #map oa.mapid matches 2..4 run return 0
# 1.9.186: 洞窟は80回まで（以前は40回）
execute if score #sup_try br.tmp matches 80.. run return 0
function oa:br/supply/place_try with storage oa:br_spawn
