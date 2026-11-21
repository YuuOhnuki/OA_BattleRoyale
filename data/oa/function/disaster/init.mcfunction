# 試合開始時に呼ぶ（br/start）。災害の抽選をやり直し、建物の中に封印の宝珠を置く。
# 無効化：/scoreboard players set #dis_off br.tmp 1（通常の災害の抽選）、#relic_off br.tmp 1（封印の宝珠）
function oa:disaster/cfg_defaults
scoreboard players set #3 br.tmp 3
function oa:disaster/halt_all
function oa:disaster/last_clear
scoreboard players set #dis_warn br.tmp 0
scoreboard players set #dis_left br.tmp 0
scoreboard players set #dis_was br.tmp 0
scoreboard players set #dis_last br.tmp 0
function oa:disaster/cooldown_first with storage oa:disaster cfg
scoreboard players set #dis_phase br.tmp 0
function oa:disaster/clear_marks
function oa:disaster/mobs_kill
execute as @a run function oa:disaster/player_clear
bossbar set oa:disaster visible false
execute unless score #relic_off br.tmp matches 1 if score #map oa.mapid matches 0 in oa:br as @e[type=minecraft:marker,tag=br.chest,sort=random,limit=6] at @s run function oa:disaster/relic/make
execute unless score #relic_off br.tmp matches 1 if score #map oa.mapid matches 1 in oa:br_nether as @e[type=minecraft:marker,tag=br.chest,sort=random,limit=6] at @s run function oa:disaster/relic/make
execute unless score #relic_off br.tmp matches 1 if score #map oa.mapid matches 2 in oa:br_cave as @e[type=minecraft:marker,tag=br.chest,sort=random,limit=6] at @s run function oa:disaster/relic/make
execute unless score #relic_off br.tmp matches 1 run tellraw @a[tag=br.playing] [{text:"✦ ",color:"light_purple"},{text:"建物の中に「封印の宝珠」がある。右クリックで5秒かけて解錠すると、戦利品が手に入る。",color:"gray"}]
# 1.9.191: 災害コンボ・TNTの雨を止める
function oa:disaster/combo/reset
scoreboard players set #g_jp_win oa.tmp 0
