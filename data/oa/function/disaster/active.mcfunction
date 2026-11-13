scoreboard players remove #dis_left br.tmp 1
execute if score #dis_kind br.tmp matches 1 run function oa:disaster/k1/second
execute if score #dis_kind br.tmp matches 2 run function oa:disaster/k2/second
execute if score #dis_kind br.tmp matches 3 run function oa:disaster/k3/second
execute if score #dis_kind br.tmp matches 4 run function oa:disaster/k4/second
execute if score #dis_kind br.tmp matches 5 run function oa:disaster/k5/second
execute if score #dis_kind br.tmp matches 6 run function oa:disaster/k6/second
execute if score #dis_left br.tmp matches ..0 run function oa:disaster/end
