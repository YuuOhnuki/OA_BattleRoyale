scoreboard players set #pulse br.tmp 0
scoreboard players operation #sec br.sec = #time br.time
scoreboard players operation #sec br.sec /= #20 br.tmp
function oa:br/zone/update
execute as @a[tag=br.alive] at @s run function oa:br/zone/player
function oa:br/check_winner
execute if score #state br.state matches 1 as @a[tag=br.alive,scores={br.mdone=0}] at @s run function oa:br/mission/check
execute if score #state br.state matches 1 if score #map oa.mapid matches 0 in oa:br as @e[distance=0..,type=minecraft:marker,tag=br.supply_fx] at @s run function oa:br/supply/fx
execute if score #state br.state matches 1 if score #map oa.mapid matches 1 in oa:br_nether as @e[distance=0..,type=minecraft:marker,tag=br.supply_fx] at @s run function oa:br/supply/fx
execute if score #state br.state matches 1 run function oa:br/supply/second
execute if score #state br.state matches 1 run function oa:br/loot/chest_title
execute if score #state br.state matches 1 run function oa:br/phase/notify
execute if score #state br.state matches 1 run function oa:br/ui/update
# 1.9.148: 試合中の観戦者（脱落者・観戦者）が会場の外（ロビー等）にいたら、会場の中心へ戻す。1.9.150: at @s を付け、本人のいるディメンションで判定する（付けないとサーバー側の位置＝オーバーワールドで判定され、全員が毎秒戻された）
execute if score #state br.state matches 1 if data storage oa:br center as @a[gamemode=spectator,nbt=!{Health:0.0f}] unless entity @s[tag=oa.practice] at @s unless dimension oa:br unless dimension oa:br_nether run function oa:br/spec/return_center

execute if data storage oa:br center run function oa:br/world/clear_mobs with storage oa:br center
execute if score #state br.state matches 1 run function oa:disaster/second
