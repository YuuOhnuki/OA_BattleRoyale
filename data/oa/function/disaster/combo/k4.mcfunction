# 1.9.191: 災害コンボの k4 の1秒（#dis_left を一時的にこの災害の残りにする）
scoreboard players operation #dis_left br.tmp = #dc4 br.tmp
scoreboard players remove #dis_left br.tmp 1
function oa:disaster/k4/second
scoreboard players operation #dc4 br.tmp = #dis_left br.tmp
