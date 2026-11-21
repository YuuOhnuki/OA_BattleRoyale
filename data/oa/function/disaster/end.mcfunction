# 1.9.212：起きていた災害がすべて収まった（disaster/second から）。次の通常の抽選までの間隔は cfg.cd_min〜cd_max 秒
tellraw @a[tag=br.playing] {text:"✔ 災害がすべて収まりました",color:"green"}
execute if score #dc_on br.tmp matches 1 run function oa:disaster/combo/end
scoreboard players set #dis_left br.tmp 0
function oa:disaster/clear_marks
function oa:disaster/mobs_kill
function oa:disaster/cooldown with storage oa:disaster cfg
