tag @s add br.spawn_check
scoreboard players set #spawn_tries br.tmp 48
function oa:br/spawn_retry
execute unless score #spawn_floor br.flag matches 1 run scoreboard players set #spawn_ok br.flag 0
tag @s remove br.spawn_check
