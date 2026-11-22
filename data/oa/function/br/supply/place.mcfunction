kill @e[type=minecraft:marker,tag=br.supply_new]
$summon minecraft:marker $(x) $(y) $(z) {Tags:["br.supply_new"]}
# 1.9.161: 屋根・木・岩などの上に落ちないよう、自然の地面で周りが平らな場所が出るまで選び直す（最大20回。出なければ最後の場所）
scoreboard players set #sup_try br.tmp 0
scoreboard players set #ok br.flag 0
function oa:br/supply/place_try with storage oa:br_spawn
# 1.9.167: 洞窟で40回選んでも良い場所がなければ、神殿の中（中心から東へ10）に落とす（最後の場所は奈落のことがある）
# 1.9.186: まず範囲内のランダムな通常チェストの横（br/supply/cave_chest）。それもなければ神殿
execute if score #map oa.mapid matches 2..4 unless score #sup_good br.tmp matches 1 as @e[type=minecraft:marker,tag=br.supply_new,limit=1] run function oa:br/supply/cave_chest with storage oa:br_spawn
execute if score #map oa.mapid matches 2..4 unless score #sup_good br.tmp matches 1 as @e[type=minecraft:marker,tag=br.supply_new,limit=1] run function oa:br/supply/cave_fallback with storage oa:br center
execute if score #map oa.mapid matches 2..4 run scoreboard players set #ok br.flag 1
execute if score #ok br.flag matches 0 run kill @e[type=minecraft:marker,tag=br.supply_new]
execute if score #ok br.flag matches 1 as @e[type=minecraft:marker,tag=br.supply_new,limit=1] at @s run function oa:br/supply/preview
