execute if score #half br.tmp matches ..5000 run return 0
data modify storage oa:br_spawn x set from storage oa:br center.x
data modify storage oa:br_spawn z set from storage oa:br center.z
data modify storage oa:br_spawn y set from storage oa:br center.y
scoreboard players operation #range br.tmp = #half br.tmp
scoreboard players operation #range br.tmp /= #1000 br.tmp
scoreboard players remove #range br.tmp 8
execute store result storage oa:br_spawn range int 1 run scoreboard players get #range br.tmp
execute in oa:br run function oa:br/supply/place with storage oa:br_spawn
