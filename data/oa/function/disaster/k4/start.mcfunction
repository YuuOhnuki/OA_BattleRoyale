# 1.9.186: 毒霧はマップの中心から広がる（半径5から5秒ごとに5ブロックずつ、最大30）。以前は生存者3人の近くに半径9の霧3つ
scoreboard players set #dis_left br.tmp 40
scoreboard players set #fog_r br.tmp 5
function oa:disaster/k4/spawn_center with storage oa:br center
