# 生成：scripts/gen_disasters.py（直接編集しない）
# 血の月・強制パーティーの1秒。#dis_left を一時的にこの災害の残り秒にして k9/second を呼ぶ
scoreboard players operation #dis_left br.tmp = #ds9 br.tmp
scoreboard players remove #dis_left br.tmp 1
function oa:disaster/k9/second
scoreboard players operation #ds9 br.tmp = #dis_left br.tmp
execute if score #ds9 br.tmp matches ..0 run function oa:disaster/stop/k9
