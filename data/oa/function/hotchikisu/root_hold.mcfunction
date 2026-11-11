execute store result storage oa:args id int 1 run scoreboard players get @s oa.id
function oa:hotchikisu/root_load with storage oa:args
execute at @s if score #clock oa.beat matches 0 run function oa:hotchikisu/root_fx
