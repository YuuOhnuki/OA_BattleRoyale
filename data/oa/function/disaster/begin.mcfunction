execute unless data storage oa:br center run return 0
data modify storage oa:disaster a.key set from storage oa:maps current
function oa:disaster/pool_step with storage oa:disaster a
execute if score #dis_kind br.tmp = #dis_last br.tmp run function oa:disaster/pool_step with storage oa:disaster a
execute unless score #dis_kind br.tmp matches 1..6 run return run scoreboard players set #dis_kind br.tmp 0
scoreboard players operation #dis_last br.tmp = #dis_kind br.tmp
execute if score #dis_kind br.tmp matches 1 run function oa:disaster/k1/start
execute if score #dis_kind br.tmp matches 2 run function oa:disaster/k2/start
execute if score #dis_kind br.tmp matches 3 run function oa:disaster/k3/start
execute if score #dis_kind br.tmp matches 4 run function oa:disaster/k4/start
execute if score #dis_kind br.tmp matches 5 run function oa:disaster/k5/start
execute if score #dis_kind br.tmp matches 6 run function oa:disaster/k6/start
execute as @a[tag=br.playing] at @s run playsound minecraft:entity.lightning_bolt.thunder master @s ~ ~ ~ 0.7 0.8
