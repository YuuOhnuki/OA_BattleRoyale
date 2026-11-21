# 生成：scripts/gen_disasters.py（直接編集しない）
# 重力異常の1秒。#dis_left を一時的にこの災害の残り秒にして k7/second を呼ぶ
scoreboard players operation #dis_left br.tmp = #ds7 br.tmp
scoreboard players remove #dis_left br.tmp 1
function oa:disaster/k7/second
scoreboard players operation #ds7 br.tmp = #dis_left br.tmp
execute if score #ds7 br.tmp matches ..0 run function oa:disaster/stop/k7
