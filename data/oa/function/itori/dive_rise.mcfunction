function oa:itori/jump_check
execute unless score #i_clear oa.tmp matches 1 run return run function oa:itori/dive_cancel
tp @s ~ ~ ~
