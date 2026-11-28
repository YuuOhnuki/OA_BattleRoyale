# 生成：scripts/gen_disasters.py（直接編集しない）
# 橋の崩落の1秒。#dis_left を一時的にこの災害の残り秒にして k16/second を呼ぶ
scoreboard players operation #dis_left br.tmp = #ds16 br.tmp
scoreboard players remove #dis_left br.tmp 1
function oa:disaster/k16/second
scoreboard players operation #ds16 br.tmp = #dis_left br.tmp
execute if score #ds16 br.tmp matches ..0 run function oa:disaster/stop/k16
