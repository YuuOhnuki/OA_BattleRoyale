# 生成：scripts/gen_disasters.py（直接編集しない）
# 予定（#pN=1）の災害を一斉に始める。今起きている同じ災害には重ねない
function oa:disaster/last_clear
execute if score #p1 br.tmp matches 1 unless score #ds1 br.tmp matches 1.. run function oa:disaster/go/k1
execute if score #p2 br.tmp matches 1 unless score #ds2 br.tmp matches 1.. run function oa:disaster/go/k2
execute if score #p3 br.tmp matches 1 unless score #ds3 br.tmp matches 1.. run function oa:disaster/go/k3
execute if score #p4 br.tmp matches 1 unless score #ds4 br.tmp matches 1.. run function oa:disaster/go/k4
execute if score #p5 br.tmp matches 1 unless score #ds5 br.tmp matches 1.. run function oa:disaster/go/k5
execute if score #p6 br.tmp matches 1 unless score #ds6 br.tmp matches 1.. run function oa:disaster/go/k6
execute if score #p7 br.tmp matches 1 unless score #ds7 br.tmp matches 1.. run function oa:disaster/go/k7
execute if score #p8 br.tmp matches 1 unless score #ds8 br.tmp matches 1.. run function oa:disaster/go/k8
execute if score #p9 br.tmp matches 1 unless score #ds9 br.tmp matches 1.. run function oa:disaster/go/k9
execute if score #p10 br.tmp matches 1 unless score #ds10 br.tmp matches 1.. run function oa:disaster/go/k10
execute if score #p11 br.tmp matches 1 unless score #ds11 br.tmp matches 1.. run function oa:disaster/go/k11
execute if score #p12 br.tmp matches 1 unless score #ds12 br.tmp matches 1.. run function oa:disaster/go/k12
function oa:disaster/plan_clear
