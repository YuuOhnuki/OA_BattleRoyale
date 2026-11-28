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
execute if score #p13 br.tmp matches 1 unless score #ds13 br.tmp matches 1.. run function oa:disaster/go/k13
execute if score #p14 br.tmp matches 1 unless score #ds14 br.tmp matches 1.. run function oa:disaster/go/k14
execute if score #p15 br.tmp matches 1 unless score #ds15 br.tmp matches 1.. run function oa:disaster/go/k15
execute if score #p16 br.tmp matches 1 unless score #ds16 br.tmp matches 1.. run function oa:disaster/go/k16
execute if score #p17 br.tmp matches 1 unless score #ds17 br.tmp matches 1.. run function oa:disaster/go/k17
execute if score #p18 br.tmp matches 1 unless score #ds18 br.tmp matches 1.. run function oa:disaster/go/k18
function oa:disaster/plan_clear
