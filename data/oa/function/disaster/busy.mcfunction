# 1.9.161: 災害の合図が、エリアの縮小・空中補給の知らせと重ならないようにする。#dis_busy=1 の間は新しい災害を始めない（秒 #sec）
# 縮小の開始（120・240・360秒）の前10秒〜後8秒、補給の予告から着地まで（195〜225・315〜345・435〜465秒）の前10秒〜後8秒
scoreboard players set #dis_busy br.tmp 0
execute if score #sec br.sec matches 110..128 run scoreboard players set #dis_busy br.tmp 1
execute if score #sec br.sec matches 185..233 run scoreboard players set #dis_busy br.tmp 1
execute if score #sec br.sec matches 230..248 run scoreboard players set #dis_busy br.tmp 1
execute if score #sec br.sec matches 305..353 run scoreboard players set #dis_busy br.tmp 1
execute if score #sec br.sec matches 350..368 run scoreboard players set #dis_busy br.tmp 1
execute if score #sec br.sec matches 425..473 run scoreboard players set #dis_busy br.tmp 1
