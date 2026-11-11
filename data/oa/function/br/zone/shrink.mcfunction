scoreboard players set #half br.tmp 150000
scoreboard players set #phase br.tmp 0
scoreboard players set #next br.tmp 120
scoreboard players set #shrinking br.flag 0
execute if score #sec br.sec matches 120.. run scoreboard players set #half br.tmp 115000
execute if score #sec br.sec matches 120.. run scoreboard players set #phase br.tmp 1
execute if score #sec br.sec matches 120..179 run function oa:br/zone/phase_1
execute if score #sec br.sec matches 240.. run scoreboard players set #half br.tmp 80000
execute if score #sec br.sec matches 240.. run scoreboard players set #phase br.tmp 2
execute if score #sec br.sec matches 240..299 run function oa:br/zone/phase_2
execute if score #sec br.sec matches 360.. run scoreboard players set #half br.tmp 45000
execute if score #sec br.sec matches 360.. run scoreboard players set #phase br.tmp 3
execute if score #sec br.sec matches 360..419 run function oa:br/zone/phase_3
execute if score #sec br.sec matches 540.. run scoreboard players set #half br.tmp 10000
execute if score #sec br.sec matches 540.. run scoreboard players set #phase br.tmp 4
execute if score #sec br.sec matches 540..599 run function oa:br/zone/phase_4
execute if score #sec br.sec matches 120.. run scoreboard players set #next br.tmp 240
execute if score #sec br.sec matches 240.. run scoreboard players set #next br.tmp 360
execute if score #sec br.sec matches 360.. run scoreboard players set #next br.tmp 540
execute if score #sec br.sec matches 540.. run scoreboard players set #next br.tmp 600
scoreboard players operation #next br.tmp -= #sec br.sec
execute if score #next br.tmp matches ..-1 run scoreboard players set #next br.tmp 0
