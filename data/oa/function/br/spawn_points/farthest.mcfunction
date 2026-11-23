# 最初だけランダム。以降は既に選んだ地点への最小水平距離を最大化。タイはランダム開始順。
scoreboard players operation #scan br.tmp = #point_pick br.tmp
scoreboard players operation #scan_n br.tmp = #point_max br.tmp
scoreboard players add #scan_n br.tmp 1
scoreboard players operation #scan_total br.tmp = #scan_n br.tmp
scoreboard players set #best_distance br.tmp -1
function oa:br/spawn_points/scan
