scoreboard players set #pulse br.tmp 0
scoreboard players operation #sec br.sec = #time br.time
scoreboard players operation #sec br.sec /= #20 br.tmp
function oa:br/check_winner
execute if score #state br.state matches 1 as @a[tag=br.alive,scores={br.mdone=0}] at @s run function oa:br/mission/check
# 1.9.223：チェスト25個・鉱石50個のごほうび
execute if score #state br.state matches 1 as @a[tag=br.alive] at @s run function oa:br/yu_bonus
execute if score #state br.state matches 1 if score #map oa.mapid matches 0 in oa:br as @e[distance=0..,type=minecraft:marker,tag=br.supply_fx] at @s run function oa:br/supply/fx
execute if score #state br.state matches 1 if score #map oa.mapid matches 1 in oa:br_nether as @e[distance=0..,type=minecraft:marker,tag=br.supply_fx] at @s run function oa:br/supply/fx
execute if score #state br.state matches 1 if score #map oa.mapid matches 2 in oa:br_cave as @e[distance=0..,type=minecraft:marker,tag=br.supply_fx] at @s run function oa:br/supply/fx
execute if score #state br.state matches 1 if score #map oa.mapid matches 3 in oa:br_sky as @e[distance=0..,type=minecraft:marker,tag=br.supply_fx] at @s run function oa:br/supply/fx
execute if score #state br.state matches 1 if score #map oa.mapid matches 4 in oa:br_end as @e[distance=0..,type=minecraft:marker,tag=br.supply_fx] at @s run function oa:br/supply/fx
execute if score #state br.state matches 1 run function oa:br/supply/second
execute if score #state br.state matches 1 run function oa:br/loot/open_label
# 1.9.173: 実績の毎秒の判定
execute if score #state br.state matches 1 as @a[tag=br.alive] at @s run function oa:ach/second
execute if score #state br.state matches 1 run function oa:br/ui/update
# 1.9.148: 試合中の観戦者（脱落者・観戦者）が会場の外（ロビー等）にいたら、会場の中心へ戻す。1.9.150: at @s を付け、本人のいるディメンションで判定する（付けないとサーバー側の位置＝オーバーワールドで判定され、全員が毎秒戻された）
execute if score #state br.state matches 1 if data storage oa:br center as @a[gamemode=spectator,tag=!oa.dead] unless entity @s[tag=oa.practice] at @s unless dimension oa:br unless dimension oa:br_nether unless dimension oa:br_cave unless dimension oa:br_sky unless dimension oa:br_end run function oa:br/spec/return_center

execute if data storage oa:br center run function oa:br/world/clear_mobs with storage oa:br center
execute if score #state br.state matches 1 run function oa:disaster/second
# 1.9.191: たやゆゆのガチャ「TNTの雨」の1秒
execute if score #state br.state matches 1 if score #g_tnt oa.tmp matches 1.. run function oa:tayayuyu/tnt_second
