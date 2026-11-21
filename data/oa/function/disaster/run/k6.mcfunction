# 生成：scripts/gen_disasters.py（直接編集しない）
# 濃霧の1秒。#dis_left を一時的にこの災害の残り秒にして k6/second を呼ぶ
scoreboard players operation #dis_left br.tmp = #ds6 br.tmp
scoreboard players remove #dis_left br.tmp 1
function oa:disaster/k6/second
scoreboard players operation #ds6 br.tmp = #dis_left br.tmp
execute if score #ds6 br.tmp matches ..0 run function oa:disaster/stop/k6
