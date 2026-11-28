# 1.9.261：投票された災害（#dis_vote）がこのマップで起こせて、いま起きていなければ #vote_ok=1
execute if score #dis_vote br.tmp matches 1 if score #av1 br.tmp matches 1 unless score #ds1 br.tmp matches 1.. run scoreboard players set #vote_ok br.tmp 1
execute if score #dis_vote br.tmp matches 2 if score #av2 br.tmp matches 1 unless score #ds2 br.tmp matches 1.. run scoreboard players set #vote_ok br.tmp 1
execute if score #dis_vote br.tmp matches 3 if score #av3 br.tmp matches 1 unless score #ds3 br.tmp matches 1.. run scoreboard players set #vote_ok br.tmp 1
execute if score #dis_vote br.tmp matches 4 if score #av4 br.tmp matches 1 unless score #ds4 br.tmp matches 1.. run scoreboard players set #vote_ok br.tmp 1
execute if score #dis_vote br.tmp matches 5 if score #av5 br.tmp matches 1 unless score #ds5 br.tmp matches 1.. run scoreboard players set #vote_ok br.tmp 1
execute if score #dis_vote br.tmp matches 6 if score #av6 br.tmp matches 1 unless score #ds6 br.tmp matches 1.. run scoreboard players set #vote_ok br.tmp 1
execute if score #dis_vote br.tmp matches 7 if score #av7 br.tmp matches 1 unless score #ds7 br.tmp matches 1.. run scoreboard players set #vote_ok br.tmp 1
execute if score #dis_vote br.tmp matches 8 if score #av8 br.tmp matches 1 unless score #ds8 br.tmp matches 1.. run scoreboard players set #vote_ok br.tmp 1
execute if score #dis_vote br.tmp matches 9 if score #av9 br.tmp matches 1 unless score #ds9 br.tmp matches 1.. run scoreboard players set #vote_ok br.tmp 1
execute if score #dis_vote br.tmp matches 10 if score #av10 br.tmp matches 1 unless score #ds10 br.tmp matches 1.. run scoreboard players set #vote_ok br.tmp 1
execute if score #dis_vote br.tmp matches 11 if score #av11 br.tmp matches 1 unless score #ds11 br.tmp matches 1.. run scoreboard players set #vote_ok br.tmp 1
execute if score #dis_vote br.tmp matches 12 if score #av12 br.tmp matches 1 unless score #ds12 br.tmp matches 1.. run scoreboard players set #vote_ok br.tmp 1
