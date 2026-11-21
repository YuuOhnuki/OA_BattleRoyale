# 220000等分：固定5種と、残り11種を各約7.864%。管理者の次回固定は維持。
execute store result score #gacha_r oa.tmp run random value 1..220000
execute if score #gacha_r oa.tmp matches 1..17300 run scoreboard players set #gacha_roll oa.tmp 1
execute if score #gacha_r oa.tmp matches 17301..34600 run scoreboard players set #gacha_roll oa.tmp 2
execute if score #gacha_r oa.tmp matches 34601..43400 run scoreboard players set #gacha_roll oa.tmp 3
execute if score #gacha_r oa.tmp matches 43401..60700 run scoreboard players set #gacha_roll oa.tmp 4
execute if score #gacha_r oa.tmp matches 60701..78000 run scoreboard players set #gacha_roll oa.tmp 5
execute if score #gacha_r oa.tmp matches 78001..95300 run scoreboard players set #gacha_roll oa.tmp 6
execute if score #gacha_r oa.tmp matches 95301..112600 run scoreboard players set #gacha_roll oa.tmp 7
execute if score #gacha_r oa.tmp matches 112601..129900 run scoreboard players set #gacha_roll oa.tmp 8
execute if score #gacha_r oa.tmp matches 129901..147200 run scoreboard players set #gacha_roll oa.tmp 9
execute if score #gacha_r oa.tmp matches 147201..156000 run scoreboard players set #gacha_roll oa.tmp 10
execute if score #gacha_r oa.tmp matches 156001..173300 run scoreboard players set #gacha_roll oa.tmp 11
execute if score #gacha_r oa.tmp matches 173301..190600 run scoreboard players set #gacha_roll oa.tmp 12
execute if score #gacha_r oa.tmp matches 190601..207900 run scoreboard players set #gacha_roll oa.tmp 13
execute if score #gacha_r oa.tmp matches 207901..209000 run scoreboard players set #gacha_roll oa.tmp 14
execute if score #gacha_r oa.tmp matches 209001..215600 run scoreboard players set #gacha_roll oa.tmp 15
execute if score #gacha_r oa.tmp matches 215601..220000 run scoreboard players set #gacha_roll oa.tmp 16
execute if score #gacha_force oa.tmp matches 1..16 run scoreboard players operation #gacha_roll oa.tmp = #gacha_force oa.tmp
scoreboard players set #gacha_force oa.tmp 0
