# 1.9.191: 災害コンボの k1 の1秒（#dis_left を一時的にこの災害の残りにする）
scoreboard players operation #dis_left br.tmp = #dc1 br.tmp
scoreboard players remove #dis_left br.tmp 1
function oa:disaster/k1/second
scoreboard players operation #dc1 br.tmp = #dis_left br.tmp
execute if score #dc1 br.tmp matches ..0 run function oa:disaster/k1/end
