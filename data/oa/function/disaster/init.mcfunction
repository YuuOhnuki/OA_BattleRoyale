# 試合開始時に呼ぶ（br/start）。災害の抽選とギミックの配置をやり直す。
# 無効化：/scoreboard players set #dis_off br.tmp 1（災害）、#gm_off br.tmp 1（ギミック）
scoreboard players set #3 br.tmp 3
scoreboard players set #dis_kind br.tmp 0
scoreboard players set #dis_left br.tmp 0
scoreboard players set #dis_last br.tmp 0
execute store result score #dis_cd br.tmp run random value 50..80
scoreboard players set #gm_cnt br.tmp 0
scoreboard players set #gm_try br.tmp 0
function oa:disaster/clear_marks
