# 1.9.261：投票された災害を予定に入れる（抽選ですでに選ばれていれば足さない）
execute if score #dis_vote br.tmp matches 1 unless score #p1 br.tmp matches 1 run scoreboard players add #plan_n br.tmp 1
execute if score #dis_vote br.tmp matches 1 run scoreboard players set #p1 br.tmp 1
execute if score #dis_vote br.tmp matches 2 unless score #p2 br.tmp matches 1 run scoreboard players add #plan_n br.tmp 1
execute if score #dis_vote br.tmp matches 2 run scoreboard players set #p2 br.tmp 1
execute if score #dis_vote br.tmp matches 3 unless score #p3 br.tmp matches 1 run scoreboard players add #plan_n br.tmp 1
execute if score #dis_vote br.tmp matches 3 run scoreboard players set #p3 br.tmp 1
execute if score #dis_vote br.tmp matches 4 unless score #p4 br.tmp matches 1 run scoreboard players add #plan_n br.tmp 1
execute if score #dis_vote br.tmp matches 4 run scoreboard players set #p4 br.tmp 1
execute if score #dis_vote br.tmp matches 5 unless score #p5 br.tmp matches 1 run scoreboard players add #plan_n br.tmp 1
execute if score #dis_vote br.tmp matches 5 run scoreboard players set #p5 br.tmp 1
execute if score #dis_vote br.tmp matches 6 unless score #p6 br.tmp matches 1 run scoreboard players add #plan_n br.tmp 1
execute if score #dis_vote br.tmp matches 6 run scoreboard players set #p6 br.tmp 1
execute if score #dis_vote br.tmp matches 7 unless score #p7 br.tmp matches 1 run scoreboard players add #plan_n br.tmp 1
execute if score #dis_vote br.tmp matches 7 run scoreboard players set #p7 br.tmp 1
execute if score #dis_vote br.tmp matches 8 unless score #p8 br.tmp matches 1 run scoreboard players add #plan_n br.tmp 1
execute if score #dis_vote br.tmp matches 8 run scoreboard players set #p8 br.tmp 1
execute if score #dis_vote br.tmp matches 9 unless score #p9 br.tmp matches 1 run scoreboard players add #plan_n br.tmp 1
execute if score #dis_vote br.tmp matches 9 run scoreboard players set #p9 br.tmp 1
execute if score #dis_vote br.tmp matches 10 unless score #p10 br.tmp matches 1 run scoreboard players add #plan_n br.tmp 1
execute if score #dis_vote br.tmp matches 10 run scoreboard players set #p10 br.tmp 1
execute if score #dis_vote br.tmp matches 11 unless score #p11 br.tmp matches 1 run scoreboard players add #plan_n br.tmp 1
execute if score #dis_vote br.tmp matches 11 run scoreboard players set #p11 br.tmp 1
execute if score #dis_vote br.tmp matches 12 unless score #p12 br.tmp matches 1 run scoreboard players add #plan_n br.tmp 1
execute if score #dis_vote br.tmp matches 12 run scoreboard players set #p12 br.tmp 1
