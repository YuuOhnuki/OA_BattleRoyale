# 2026-11-23：出撃ターミナルが3つの台のままなら、5つの台へ置き直す（lobby/tick から。ロビーの原点 x y z を渡す）
$execute in minecraft:overworld positioned $(x) $(y) $(z) align xyz if loaded ~12 ~ ~21 if loaded ~21 ~ ~21 if entity @e[type=minecraft:interaction,tag=oa.term.br_map.0,distance=..60] unless entity @e[type=minecraft:interaction,tag=oa.term.br_map.4,distance=..60] run function oa:lobby/terminal/maps5_apply
