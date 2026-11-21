# #want 個を重複なく選ぶ（disaster/pick を最大3回）。前回の災害を避けると足りないときは、避けずに選び直す
scoreboard players set #plan_n br.tmp 0
function oa:disaster/pick
execute if score #picked br.tmp matches 1 run scoreboard players add #plan_n br.tmp 1
execute if score #plan_n br.tmp < #want br.tmp run function oa:disaster/pick
execute if score #plan_n br.tmp < #want br.tmp if score #picked br.tmp matches 1 run scoreboard players add #plan_n br.tmp 1
execute if score #plan_n br.tmp < #want br.tmp run function oa:disaster/pick
execute if score #plan_n br.tmp < #want br.tmp if score #picked br.tmp matches 1 run scoreboard players add #plan_n br.tmp 1
execute if score #plan_n br.tmp < #want br.tmp if score #avoid_last br.tmp matches 1 run function oa:disaster/pick_n_retry
