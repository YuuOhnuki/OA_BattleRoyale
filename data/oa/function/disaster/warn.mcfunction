# 災害の合図から発生までの待ち（1秒ごと、disaster/second から）。0になったら災害の種類ごとの start を実行する
scoreboard players remove #dis_warn br.tmp 1
# 1.9.157: 発生の3秒前から1秒ごとに効果音でカウントダウン（文字は出さない）。#dis_warn は発生までの残り秒数
execute if score #dis_warn br.tmp matches 3 as @a[tag=br.playing] at @s run playsound minecraft:block.note_block.pling master @s ~ ~ ~ 1 0.9
execute if score #dis_warn br.tmp matches 2 as @a[tag=br.playing] at @s run playsound minecraft:block.note_block.pling master @s ~ ~ ~ 1 1.1
execute if score #dis_warn br.tmp matches 1 as @a[tag=br.playing] at @s run playsound minecraft:block.note_block.pling master @s ~ ~ ~ 1 1.4
execute if score #dis_warn br.tmp matches 1.. run return 0
execute if score #dis_kind br.tmp matches 1 run function oa:disaster/k1/start
execute if score #dis_kind br.tmp matches 2 run function oa:disaster/k2/start
execute if score #dis_kind br.tmp matches 3 run function oa:disaster/k3/start
execute if score #dis_kind br.tmp matches 4 run function oa:disaster/k4/start
execute if score #dis_kind br.tmp matches 5 run function oa:disaster/k5/start
execute if score #dis_kind br.tmp matches 6 run function oa:disaster/k6/start
