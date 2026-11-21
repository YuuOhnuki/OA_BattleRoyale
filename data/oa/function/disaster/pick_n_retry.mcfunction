scoreboard players set #avoid_last br.tmp 0
function oa:disaster/pick
execute if score #picked br.tmp matches 1 run scoreboard players add #plan_n br.tmp 1
execute if score #plan_n br.tmp < #want br.tmp run function oa:disaster/pick
execute if score #plan_n br.tmp < #want br.tmp if score #picked br.tmp matches 1 run scoreboard players add #plan_n br.tmp 1
