function oa:itori/progress
execute store result storage oa:itori_item points int 1 run scoreboard players get @s oa.i_points
$data modify storage oa:itori_item slot set value "$(slot)"
function oa:itori/item_progress with storage oa:itori_item
