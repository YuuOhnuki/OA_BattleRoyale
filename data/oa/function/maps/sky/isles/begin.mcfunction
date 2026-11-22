# 生成: scripts/build_map_sky.py（直接編集しない）。区画（中央）のあとに呼ばれる。島を1つずつ置く（終わるまで生成中のまま）
data modify storage oa_map2:job working set value 1b
data modify storage oa:maps sky_isles set value []
data remove storage oa:maps sky_region
scoreboard players set #isle oa.map2 0
scoreboard players set #isle_wait oa.map2 0
tellraw @a[tag=br.admin] {text:"[天空島] まわりの島を置いています…",color:"gold"}
function oa:maps/sky/isles/next
