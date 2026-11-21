# アクションバー：3秒ごとに「災害の警告」と通常のバーを交互に出す（#dis_phase=1 の間だけ、当たっている人に警告。補給物資の表示中は通常側）
tag @a remove br.dis_msg
scoreboard players add #dis_t br.tmp 1
scoreboard players operation #dis_ph br.tmp = #dis_t br.tmp
scoreboard players operation #dis_ph br.tmp /= #3 br.tmp
scoreboard players set #c2 br.tmp 2
scoreboard players operation #dis_ph br.tmp %= #c2 br.tmp
scoreboard players set #dis_phase br.tmp 0
execute if score #dis_ph br.tmp matches 0 unless score #sup_phase br.tmp matches 1 run scoreboard players set #dis_phase br.tmp 1
