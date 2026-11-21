# 災害の予告から発生までの待ち（1秒ごと）。0になったら予定の災害をすべて始める
scoreboard players remove #dis_warn br.tmp 1
# 1.9.157: 発生の3秒前から1秒ごとに効果音でカウントダウン
execute if score #dis_warn br.tmp matches 3 as @a[tag=br.playing] at @s run playsound minecraft:block.note_block.pling master @s ~ ~ ~ 1 0.9
execute if score #dis_warn br.tmp matches 2 as @a[tag=br.playing] at @s run playsound minecraft:block.note_block.pling master @s ~ ~ ~ 1 1.1
execute if score #dis_warn br.tmp matches 1 as @a[tag=br.playing] at @s run playsound minecraft:block.note_block.pling master @s ~ ~ ~ 1 1.4
execute if score #dis_warn br.tmp matches 1.. run return 0
function oa:disaster/start_planned
function oa:disaster/count
