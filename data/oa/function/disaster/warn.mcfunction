# 災害の合図から発生までの待ち（1秒ごと、disaster/second から）。0になったら災害の種類ごとの start を実行する
scoreboard players remove #dis_warn br.tmp 1
execute if score #dis_warn br.tmp matches 1.. run return 0
execute if score #dis_kind br.tmp matches 1 run function oa:disaster/k1/start
execute if score #dis_kind br.tmp matches 2 run function oa:disaster/k2/start
execute if score #dis_kind br.tmp matches 3 run function oa:disaster/k3/start
execute if score #dis_kind br.tmp matches 4 run function oa:disaster/k4/start
execute if score #dis_kind br.tmp matches 5 run function oa:disaster/k5/start
execute if score #dis_kind br.tmp matches 6 run function oa:disaster/k6/start
