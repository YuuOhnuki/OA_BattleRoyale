# 補給の着地点として良いか（マーカーとして実行。spreadplayers のあと）。良ければ #sup_good=1
# 草・花の上に置かれたら、その草の位置まで下げてから調べる（背の高い草は2段）
execute unless block ~ ~-1 ~ #minecraft:air if block ~ ~-1 ~ #oa:spawn_clear run return run function oa:br/supply/ground_down
# 足元が自然の地面（葉・丸太・板・階段・柵などの屋根や障害物ではない）
execute unless block ~ ~-1 ~ #oa:supply_ground run return 0
# 足・頭・その上が通れる（張り出した枝や屋根の下でない）
execute unless block ~ ~ ~ #oa:spawn_clear run return 0
execute unless block ~ ~1 ~ #oa:spawn_clear run return 0
execute unless block ~ ~2 ~ #oa:spawn_clear run return 0
# 岩や柱の上でない：前後左右2ブロック先が2段以上の段差（下2マスとも通れる）なら不可
execute if block ~2 ~-1 ~ #oa:spawn_clear if block ~2 ~-2 ~ #oa:spawn_clear run return 0
execute if block ~-2 ~-1 ~ #oa:spawn_clear if block ~-2 ~-2 ~ #oa:spawn_clear run return 0
execute if block ~ ~-1 ~2 #oa:spawn_clear if block ~ ~-2 ~2 #oa:spawn_clear run return 0
execute if block ~ ~-1 ~-2 #oa:spawn_clear if block ~ ~-2 ~-2 #oa:spawn_clear run return 0
scoreboard players set #sup_good br.tmp 1
