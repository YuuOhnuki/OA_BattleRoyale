scoreboard players set #spawn_depth br.tmp 32
execute at @s align xyz positioned ~0.5 ~ ~0.5 run function oa:br/spawn_scan
execute if score #spawn_floor br.flag matches 1 run return 1
scoreboard players remove #spawn_tries br.tmp 1
execute if score #spawn_tries br.tmp matches ..0 run return 0
function oa:br/spawn_reroll with storage oa:br center
function oa:br/spawn_retry
