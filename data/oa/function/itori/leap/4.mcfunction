data modify storage oa:itori dy set value -0.02f
execute store result storage oa:itori yaw float 0.001 run scoreboard players get @s oa.i_yaw
function oa:itori/leap_move with storage oa:itori
