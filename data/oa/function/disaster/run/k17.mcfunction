# 生成：scripts/gen_disasters.py（直接編集しない）
# 虚空の侵食の1秒。#dis_left を一時的にこの災害の残り秒にして k17/second を呼ぶ
scoreboard players operation #dis_left br.tmp = #ds17 br.tmp
scoreboard players remove #dis_left br.tmp 1
function oa:disaster/k17/second
scoreboard players operation #ds17 br.tmp = #dis_left br.tmp
execute if score #ds17 br.tmp matches ..0 run function oa:disaster/stop/k17
