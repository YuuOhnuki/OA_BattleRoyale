# 1.9.191: 災害コンボの k2 の1秒（#dis_left を一時的にこの災害の残りにする）
scoreboard players operation #dis_left br.tmp = #dc2 br.tmp
scoreboard players remove #dis_left br.tmp 1
function oa:disaster/k2/second
scoreboard players operation #dc2 br.tmp = #dis_left br.tmp
