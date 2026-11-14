kill @e[type=minecraft:marker,tag=br.supply_new]
$summon minecraft:marker $(x) $(y) $(z) {Tags:["br.supply_new"]}
# 1.9.161: 屋根・木・岩などの上に落ちないよう、自然の地面で周りが平らな場所が出るまで選び直す（最大20回。出なければ最後の場所）
scoreboard players set #sup_try br.tmp 0
scoreboard players set #ok br.flag 0
function oa:br/supply/place_try with storage oa:br_spawn
execute if score #ok br.flag matches 0 run kill @e[type=minecraft:marker,tag=br.supply_new]
execute if score #ok br.flag matches 1 as @e[type=minecraft:marker,tag=br.supply_new,limit=1] at @s run function oa:br/supply/preview
