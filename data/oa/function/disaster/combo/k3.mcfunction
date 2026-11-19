# 1.9.191: 災害コンボの k3 の1秒（#dis_left を一時的にこの災害の残りにする）
scoreboard players operation #dis_left br.tmp = #dc3 br.tmp
scoreboard players remove #dis_left br.tmp 1
function oa:disaster/k3/second
scoreboard players operation #dc3 br.tmp = #dis_left br.tmp
