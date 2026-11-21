# 生成：scripts/gen_disasters.py（直接編集しない）
# 寒波の1秒。#dis_left を一時的にこの災害の残り秒にして k2/second を呼ぶ
scoreboard players operation #dis_left br.tmp = #ds2 br.tmp
scoreboard players remove #dis_left br.tmp 1
function oa:disaster/k2/second
scoreboard players operation #ds2 br.tmp = #dis_left br.tmp
execute if score #ds2 br.tmp matches ..0 run function oa:disaster/stop/k2
