# 生成：scripts/gen_disasters.py（直接編集しない）
# エンダードラゴンの1秒。#dis_left を一時的にこの災害の残り秒にして k18/second を呼ぶ
scoreboard players operation #dis_left br.tmp = #ds18 br.tmp
scoreboard players remove #dis_left br.tmp 1
function oa:disaster/k18/second
scoreboard players operation #ds18 br.tmp = #dis_left br.tmp
execute if score #ds18 br.tmp matches ..0 run function oa:disaster/stop/k18
