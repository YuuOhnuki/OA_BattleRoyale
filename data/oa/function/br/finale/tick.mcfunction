scoreboard players add #fclock br.tmp 1
execute if score #fclock br.tmp matches 8.. run scoreboard players set #fclock br.tmp 0
execute unless score #fclock br.tmp matches 0 run return 0
scoreboard players add #fstep br.tmp 1
execute if score #fstep br.tmp matches 3.. run scoreboard players set #fstep br.tmp 0
execute if score #fstep br.tmp matches 0 run function oa:br/finale/burst_pick
scoreboard players set #2 br.tmp 2
scoreboard players operation #fpar br.tmp = #fstep br.tmp
scoreboard players operation #fpar br.tmp %= #2 br.tmp
execute if score #fpar br.tmp matches 0 if data storage oa:br center run function oa:br/finale/lamps_on with storage oa:br center
execute if score #fpar br.tmp matches 1 if data storage oa:br center run function oa:br/finale/lamps_off with storage oa:br center
