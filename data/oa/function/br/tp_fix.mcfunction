# 開始TP後に、地表に立っているかを確かめて補正する（実行者：参加者、位置：本人）
# 1.9.155: 判定を、ブロック単位にそろえた高さでの地表判定（spawn_points/check：足元が固体、体の2マスが空き）にした。
#   体が埋まっていれば真上の最初の立てる場所へ（最大80）、少し浮いていれば真下の地表へ（最大4）。
#   開始TPの直後（tp_position）と、3tick後から10tickごとに計7回（tp_fix_all）呼ばれる。
execute unless loaded ~ ~ ~ run return 0
execute align y run function oa:br/spawn_points/check
execute if score #spawn_floor br.flag matches 1 run return 0
scoreboard players set #tpfix_n br.tmp 80
execute unless block ~ ~ ~ #oa:spawn_clear align y run return run function oa:br/tp_fix_up
execute unless block ~ ~1 ~ #oa:spawn_clear align y run return run function oa:br/tp_fix_up
scoreboard players set #tpfix_n br.tmp 4
execute align y positioned ~ ~-1 ~ run function oa:br/tp_fix_down
