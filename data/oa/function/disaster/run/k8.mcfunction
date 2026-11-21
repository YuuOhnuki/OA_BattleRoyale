# 生成：scripts/gen_disasters.py（直接編集しない）
# ニワトリ大量発生の1秒。#dis_left を一時的にこの災害の残り秒にして k8/second を呼ぶ
scoreboard players operation #dis_left br.tmp = #ds8 br.tmp
scoreboard players remove #dis_left br.tmp 1
function oa:disaster/k8/second
scoreboard players operation #ds8 br.tmp = #dis_left br.tmp
execute if score #ds8 br.tmp matches ..0 run function oa:disaster/stop/k8
