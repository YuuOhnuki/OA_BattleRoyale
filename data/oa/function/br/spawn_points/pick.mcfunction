execute unless data storage oa:spawn_pool points[0] run return run scoreboard players set #spawn_ok br.flag 0
execute store result score #point_max br.tmp run data get storage oa:spawn_pool points
scoreboard players remove #point_max br.tmp 1
execute store result storage oa:spawn_pool max int 1 run scoreboard players get #point_max br.tmp
function oa:br/spawn_points/random with storage oa:spawn_pool
execute store result storage oa:spawn_pool index int 1 run scoreboard players get #point_pick br.tmp
function oa:br/spawn_points/select with storage oa:spawn_pool
