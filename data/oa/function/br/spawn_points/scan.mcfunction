execute store result storage oa:spawn_pool scan int 1 run scoreboard players get #scan br.tmp
function oa:br/spawn_points/candidate with storage oa:spawn_pool
execute if score #min_distance br.tmp > #best_distance br.tmp run scoreboard players operation #point_pick br.tmp = #scan br.tmp
scoreboard players operation #best_distance br.tmp > #min_distance br.tmp
scoreboard players add #scan br.tmp 1
scoreboard players operation #scan br.tmp %= #scan_total br.tmp
scoreboard players remove #scan_n br.tmp 1
execute if score #scan_n br.tmp matches 1.. run function oa:br/spawn_points/scan
