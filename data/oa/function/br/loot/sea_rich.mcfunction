# 既存会場も次の試合の初回補充から変更。中心からの相対座標で海中遺跡2か所だけを特別に。
execute unless dimension oa:br run return 0
execute store result score #sea_x br.tmp run data get entity @s Pos[0] 1000
execute store result score #sea_z br.tmp run data get entity @s Pos[2] 1000
scoreboard players operation #sea_x br.tmp -= #cx br.x
scoreboard players operation #sea_z br.tmp -= #cz br.z
execute if score #sea_x br.tmp matches -132500 if score #sea_z br.tmp matches 125500 run tag @s add br.rich
execute if score #sea_x br.tmp matches 131500 if score #sea_z br.tmp matches 113500 run tag @s add br.rich
