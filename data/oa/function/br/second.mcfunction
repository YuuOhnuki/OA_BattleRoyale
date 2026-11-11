scoreboard players set #pulse br.tmp 0
scoreboard players operation #sec br.sec = #time br.time
scoreboard players operation #sec br.sec /= #20 br.tmp
function oa:br/zone/update
execute as @a[tag=br.alive] at @s run function oa:br/zone/player
function oa:br/check_winner
execute if score #state br.state matches 1 as @a[tag=br.alive,scores={br.mdone=0}] at @s run function oa:br/mission/check
execute if score #state br.state matches 1 in oa:br as @e[distance=0..,type=minecraft:marker,tag=br.supply_fx] at @s run function oa:br/supply/fx
execute if score #state br.state matches 1 run function oa:br/supply/second
execute if score #state br.state matches 1 run function oa:br/phase/notify
execute if score #state br.state matches 1 run function oa:br/ui/update

execute if data storage oa:br center run function oa:br/world/clear_mobs with storage oa:br center
