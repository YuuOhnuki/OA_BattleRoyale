# 管理者用：起きている災害・予告をすべて止める（次の抽選までの間隔は通常どおり）
function oa:disaster/halt_all
scoreboard players set #dis_warn br.tmp 0
scoreboard players set #dc_warn br.tmp 0
scoreboard players set #dc_on br.tmp 0
function oa:disaster/clear_marks
function oa:disaster/mobs_kill
execute as @a run function oa:disaster/player_clear
bossbar set oa:disaster visible false
tellraw @s {"text":"災害をすべて止めました","color":"green"}
