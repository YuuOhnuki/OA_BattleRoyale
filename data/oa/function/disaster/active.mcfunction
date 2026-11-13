scoreboard players remove #dis_left br.tmp 1
# アクションバー：3秒ごとに「災害の警告」と通常のバーを交互に出す（#dis_phase=1 の間だけ警告。補給物資の表示中は通常側）
tag @a remove br.dis_msg
scoreboard players operation #dis_ph br.tmp = #dis_left br.tmp
scoreboard players operation #dis_ph br.tmp /= #3 br.tmp
scoreboard players set #c2 br.tmp 2
scoreboard players operation #dis_ph br.tmp %= #c2 br.tmp
scoreboard players set #dis_phase br.tmp 0
execute if score #dis_ph br.tmp matches 0 unless score #sup_phase br.tmp matches 1 run scoreboard players set #dis_phase br.tmp 1
execute if score #dis_kind br.tmp matches 1 run function oa:disaster/k1/second
execute if score #dis_kind br.tmp matches 2 run function oa:disaster/k2/second
execute if score #dis_kind br.tmp matches 3 run function oa:disaster/k3/second
execute if score #dis_kind br.tmp matches 4 run function oa:disaster/k4/second
execute if score #dis_kind br.tmp matches 5 run function oa:disaster/k5/second
execute if score #dis_kind br.tmp matches 6 run function oa:disaster/k6/second
execute if score #dis_left br.tmp matches ..0 run function oa:disaster/end
