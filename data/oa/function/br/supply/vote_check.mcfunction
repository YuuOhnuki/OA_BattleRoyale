# 1.9.261：補給の落下地点が観戦者の投票の方角（中心から見て）か。違えば #sup_good=0
execute store result score #svx br.tmp run data get entity @s Pos[0]
execute store result score #svz br.tmp run data get entity @s Pos[2]
execute store result score #scx br.tmp run data get storage oa:br center.x
execute store result score #scz br.tmp run data get storage oa:br center.z
scoreboard players operation #svx br.tmp -= #scx br.tmp
scoreboard players operation #svz br.tmp -= #scz br.tmp
execute if score #sup_vote br.tmp matches 1 unless score #svx br.tmp matches 0.. run scoreboard players set #sup_good br.tmp 0
execute if score #sup_vote br.tmp matches 1 unless score #svz br.tmp matches ..-1 run scoreboard players set #sup_good br.tmp 0
execute if score #sup_vote br.tmp matches 2 unless score #svx br.tmp matches ..-1 run scoreboard players set #sup_good br.tmp 0
execute if score #sup_vote br.tmp matches 2 unless score #svz br.tmp matches ..-1 run scoreboard players set #sup_good br.tmp 0
execute if score #sup_vote br.tmp matches 3 unless score #svx br.tmp matches 0.. run scoreboard players set #sup_good br.tmp 0
execute if score #sup_vote br.tmp matches 3 unless score #svz br.tmp matches 0.. run scoreboard players set #sup_good br.tmp 0
execute if score #sup_vote br.tmp matches 4 unless score #svx br.tmp matches ..-1 run scoreboard players set #sup_good br.tmp 0
execute if score #sup_vote br.tmp matches 4 unless score #svz br.tmp matches 0.. run scoreboard players set #sup_good br.tmp 0
