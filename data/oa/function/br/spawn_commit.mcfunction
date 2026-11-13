tag @s add br.tpfix
execute store result storage oa:br_args id int 1 run scoreboard players get @s oa.id
function oa:br/enter_tp with storage oa:br_args
