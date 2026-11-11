scoreboard players add #serial oa.serial 1
scoreboard players operation #i_stamp oa.tmp = #serial oa.serial
function oa:combat/select_targets
tag @e[tag=oa.i_struck] remove oa.i_struck
