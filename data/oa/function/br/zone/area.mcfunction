# 1.9.218: 安全地帯の中に収まる正方形の範囲（円の半径×0.7 から余白を引いた半辺）と中心を oa:br_spawn に入れる。
# 引数 use＝"now"（今の安置）／"target"（次の収縮の目標）、margin＝余白（ブロック）。プラグインの値がなければ何もしない（呼び出し側の従来の範囲のまま）
execute unless score #zrb br.tmp matches 1.. run return 0
$execute store result storage oa:br_spawn x int 1 run scoreboard players get #z$(use)x br.x
$execute store result storage oa:br_spawn z int 1 run scoreboard players get #z$(use)z br.z
$scoreboard players operation #zone_range br.tmp = #z$(use)r br.tmp
scoreboard players operation #zone_range br.tmp *= #7 br.tmp
scoreboard players operation #zone_range br.tmp /= #10 br.tmp
$scoreboard players remove #zone_range br.tmp $(margin)
execute if score #zone_range br.tmp matches ..2 run scoreboard players set #zone_range br.tmp 3
