# 試合終了・中止時に呼ぶ（br/finish）。起きている災害をすべて止め、天候・印・災害の動物・効果を片付ける
function oa:disaster/halt_all
# 1.9.191: 災害コンボ・TNTの雨を止める
function oa:disaster/combo/reset
scoreboard players set #dis_warn br.tmp 0
scoreboard players set #dis_left br.tmp 0
scoreboard players set #dis_was br.tmp 0
scoreboard players set #dis_phase br.tmp 0
tag @a remove br.dis_msg
function oa:disaster/clear_marks
function oa:disaster/mobs_kill
execute as @a run function oa:disaster/player_clear
bossbar set oa:disaster visible false
effect clear @a[tag=br.playing] minecraft:darkness
effect clear @a[tag=br.playing] minecraft:nausea
