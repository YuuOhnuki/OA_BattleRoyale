# 開始TP後に体が地形に埋まっていたら、真上の最初の立てる場所へ移す（実行者：参加者、位置：本人）
execute unless loaded ~ ~ ~ run return 0
execute if block ~ ~ ~ #oa:spawn_clear if block ~ ~1 ~ #oa:spawn_clear run return 0
scoreboard players set #tpfix_n br.tmp 80
function oa:br/tp_fix_up
