# 終盤演出の時計（0.4秒ごとに #fstep を 0→1→2 と回す）。演出の中身は選択中マップの定義（oa:finale/tick）が決める
scoreboard players add #fclock br.tmp 1
execute if score #fclock br.tmp matches 8.. run scoreboard players set #fclock br.tmp 0
execute unless score #fclock br.tmp matches 0 run return 0
scoreboard players add #fstep br.tmp 1
execute if score #fstep br.tmp matches 3.. run scoreboard players set #fstep br.tmp 0
function oa:finale/tick
