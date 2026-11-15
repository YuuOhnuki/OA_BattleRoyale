# 1.9.182: 鉱石の点に、調べる組（br.ostg 0〜3）を順番に振る（br/loot/tick から、点として）
scoreboard players add #ostg_n br.tmp 1
execute if score #ostg_n br.tmp matches 4.. run scoreboard players set #ostg_n br.tmp 0
scoreboard players operation @s br.ostg = #ostg_n br.tmp
