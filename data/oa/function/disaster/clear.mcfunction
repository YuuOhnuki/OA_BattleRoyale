# 試合終了・中止時に呼ぶ（br/finish）。天候を戻し、印と効果を片付ける。
execute if score #dis_kind br.tmp matches 1 run function oa:disaster/k1/end
scoreboard players set #dis_kind br.tmp 0
scoreboard players set #dis_warn br.tmp 0
scoreboard players set #dis_left br.tmp 0
scoreboard players set #dis_phase br.tmp 0
tag @a remove br.dis_msg
function oa:disaster/clear_marks
effect clear @a[tag=br.playing] minecraft:darkness
effect clear @a[tag=br.playing] minecraft:nausea
