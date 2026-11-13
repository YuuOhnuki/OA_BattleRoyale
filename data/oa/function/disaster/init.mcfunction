# 試合開始時に呼ぶ（br/start）。災害の抽選をやり直し、建物の中に封印の宝珠を置く。
# 無効化：/scoreboard players set #dis_off br.tmp 1（災害）、#relic_off br.tmp 1（封印の宝珠）
scoreboard players set #3 br.tmp 3
scoreboard players set #dis_kind br.tmp 0
scoreboard players set #dis_left br.tmp 0
scoreboard players set #dis_last br.tmp 0
execute store result score #dis_cd br.tmp run random value 50..80
scoreboard players set #dis_phase br.tmp 0
function oa:disaster/clear_marks
execute unless score #relic_off br.tmp matches 1 if score #map oa.mapid matches 0 in oa:br as @e[type=minecraft:marker,tag=br.chest,sort=random,limit=6] at @s run function oa:disaster/relic/make
execute unless score #relic_off br.tmp matches 1 if score #map oa.mapid matches 1 in oa:br_nether as @e[type=minecraft:marker,tag=br.chest,sort=random,limit=6] at @s run function oa:disaster/relic/make
execute unless score #relic_off br.tmp matches 1 run tellraw @a[tag=br.playing] [{text:"✦ ",color:"light_purple"},{text:"建物の中に「封印の宝珠」がある。右クリックで5秒かけて解錠すると、戦利品がもらえる（光と音で場所が知られる）",color:"gray"}]
