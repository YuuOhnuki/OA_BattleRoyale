scoreboard players operation #progress br.tmp = #sec br.sec
scoreboard players remove #progress br.tmp 600
scoreboard players operation #progress br.tmp *= #150 br.tmp
scoreboard players set #half br.tmp 10000
scoreboard players operation #half br.tmp -= #progress br.tmp
execute if score #half br.tmp matches ..1000 run scoreboard players set #half br.tmp 1000
