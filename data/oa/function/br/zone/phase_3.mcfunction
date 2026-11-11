scoreboard players operation #progress br.tmp = #sec br.sec
scoreboard players remove #progress br.tmp 360
scoreboard players set #delta br.tmp 35000
scoreboard players operation #progress br.tmp *= #delta br.tmp
scoreboard players operation #progress br.tmp /= #60 br.tmp
scoreboard players set #half br.tmp 80000
scoreboard players operation #half br.tmp -= #progress br.tmp
scoreboard players set #shrinking br.flag 1
