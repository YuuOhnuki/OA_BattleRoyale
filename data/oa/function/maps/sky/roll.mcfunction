# 生成: scripts/build_map_float.py sky（直接編集しない）。スロット（外周の8つの島）の中身を3種類から抽選する（map/internal/job/begin から）
execute unless score #mode oa.map2 matches 0 run return 0
execute store result score #sv0 oa.map2 run random value 0..2
execute store result score #sv1 oa.map2 run random value 0..2
execute store result score #sv2 oa.map2 run random value 0..2
execute store result score #sv3 oa.map2 run random value 0..2
execute store result score #sv4 oa.map2 run random value 0..2
execute store result score #sv5 oa.map2 run random value 0..2
execute store result score #sv6 oa.map2 run random value 0..2
execute store result score #sv7 oa.map2 run random value 0..2
function oa:maps/sky/layout
