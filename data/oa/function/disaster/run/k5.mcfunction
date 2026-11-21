# 生成：scripts/gen_disasters.py（直接編集しない）
# 地震の1秒。#dis_left を一時的にこの災害の残り秒にして k5/second を呼ぶ
scoreboard players operation #dis_left br.tmp = #ds5 br.tmp
scoreboard players remove #dis_left br.tmp 1
function oa:disaster/k5/second
scoreboard players operation #ds5 br.tmp = #dis_left br.tmp
execute if score #ds5 br.tmp matches ..0 run function oa:disaster/stop/k5
