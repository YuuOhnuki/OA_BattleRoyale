# 生成：scripts/gen_disasters.py（直接編集しない）
scoreboard players set #dis_active br.tmp 0
scoreboard players set #dis_kind br.tmp 0
execute if score #ds1 br.tmp matches 1.. run scoreboard players add #dis_active br.tmp 1
execute if score #ds2 br.tmp matches 1.. run scoreboard players add #dis_active br.tmp 1
execute if score #ds3 br.tmp matches 1.. run scoreboard players add #dis_active br.tmp 1
execute if score #ds4 br.tmp matches 1.. run scoreboard players add #dis_active br.tmp 1
execute if score #ds5 br.tmp matches 1.. run scoreboard players add #dis_active br.tmp 1
execute if score #ds6 br.tmp matches 1.. run scoreboard players add #dis_active br.tmp 1
execute if score #ds7 br.tmp matches 1.. run scoreboard players add #dis_active br.tmp 1
execute if score #ds8 br.tmp matches 1.. run scoreboard players add #dis_active br.tmp 1
execute if score #ds9 br.tmp matches 1.. run scoreboard players add #dis_active br.tmp 1
execute if score #ds10 br.tmp matches 1.. run scoreboard players add #dis_active br.tmp 1
execute if score #ds11 br.tmp matches 1.. run scoreboard players add #dis_active br.tmp 1
execute if score #dis_kind br.tmp matches 0 if score #ds1 br.tmp matches 1.. run scoreboard players set #dis_kind br.tmp 1
execute if score #dis_kind br.tmp matches 0 if score #ds2 br.tmp matches 1.. run scoreboard players set #dis_kind br.tmp 2
execute if score #dis_kind br.tmp matches 0 if score #ds3 br.tmp matches 1.. run scoreboard players set #dis_kind br.tmp 3
execute if score #dis_kind br.tmp matches 0 if score #ds4 br.tmp matches 1.. run scoreboard players set #dis_kind br.tmp 4
execute if score #dis_kind br.tmp matches 0 if score #ds5 br.tmp matches 1.. run scoreboard players set #dis_kind br.tmp 5
execute if score #dis_kind br.tmp matches 0 if score #ds6 br.tmp matches 1.. run scoreboard players set #dis_kind br.tmp 6
execute if score #dis_kind br.tmp matches 0 if score #ds7 br.tmp matches 1.. run scoreboard players set #dis_kind br.tmp 7
execute if score #dis_kind br.tmp matches 0 if score #ds8 br.tmp matches 1.. run scoreboard players set #dis_kind br.tmp 8
execute if score #dis_kind br.tmp matches 0 if score #ds9 br.tmp matches 1.. run scoreboard players set #dis_kind br.tmp 9
execute if score #dis_kind br.tmp matches 0 if score #ds10 br.tmp matches 1.. run scoreboard players set #dis_kind br.tmp 10
execute if score #dis_kind br.tmp matches 0 if score #ds11 br.tmp matches 1.. run scoreboard players set #dis_kind br.tmp 11
